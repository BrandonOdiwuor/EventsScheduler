defmodule EventsScheduler.EventController do
  use EventsScheduler.Web, :controller
  alias EventsScheduler.Event
  alias EventsScheduler.Student
  import Ecto.Changeset, only: [put_change: 3]

  plug :scrub_params, "event" when action in [:create, :update]
  plug :assign_student
  plug :authorize_student when action in [:index, :new, :create, :update, :edit, :delete]

  def index(conn, _params) do
    events = Repo.all(assoc(conn.assigns[:student], :events))
    render(conn, "index.html", events: events)
  end

  def new(conn, _params) do
    changeset = Event.changeset(%Event{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"event" => event_params}) do

    changeset =
      conn.assigns[:student]
      |> build_assoc(:events)
      |> Event.changeset(event_params)
      new_changeset = put_change(changeset, :creator, current_student(conn).name)
    case Repo.insert(new_changeset) do
      {:ok, _event} ->
        conn
        |> put_flash(:info, "Event created successfully.")
        |> redirect(to: student_event_path(conn, :index, conn.assigns[:student]))
      {:error, changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    event = Repo.get!(assoc(conn.assigns[:student], :events), id)
    render(conn, "show.html", event: event)
  end

  def edit(conn, %{"id" => id}) do
    event = Repo.get!(Event, id)
    changeset = Event.changeset(event)
    render(conn, "edit.html", event: event, changeset: changeset)
  end

  def update(conn, %{"id" => id, "event" => event_params}) do
    event = Repo.get!(Event, id)
    changeset = Event.changeset(event, event_params)

    case Repo.update(changeset) do
      {:ok, event} ->
        conn
        |> put_flash(:info, "Event updated successfully.")
        |> redirect(to: student_event_path(conn, :show, conn.assigns[:student], event))
      {:error, changeset} ->
        render(conn, "edit.html", event: event, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    event = Repo.get!(Event, id)
    Repo.delete(event)
    conn
    |> put_flash(:info, "Event deleted successfully.")
    |> redirect(to: student_event_path(conn, :index, conn.assigns[:student]))
  end

  defp assign_student(conn, _) do
    case conn.params do
       %{"student_id" => student_id} ->
         student = Repo.get(EventsScheduler.Student, student_id)
         assign(conn, :student, student)
        _ ->
          conn
    end
  end


  defp authorize_student(conn, _opts) do

    if get_session(conn, :current_student) do
      student = get_session(conn, :current_student)
      if Integer.to_string(student) == conn.params["student_id"] do
        conn
      else
        conn
          |> put_flash(:error, "You are not authorized to modify that post!")
          |> redirect(to: page_path(conn, :index))
          |> halt()
      end
    else
      conn
        |> put_flash(:error, "please log in")
        |> redirect(to: page_path(conn, :index))
    end
  end

  defp current_student(conn) do
    student_id = get_session(conn, :current_student)
    Repo.get(Student, student_id)
  end


end
