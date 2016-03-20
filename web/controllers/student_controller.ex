defmodule EventsScheduler.StudentController do
  use EventsScheduler.Web, :controller

  alias EventsScheduler.Student

  plug :scrub_params, "student" when action in [:create, :update]
  plug :admin_authentication when action in [:index, :delete]

  def index(conn, _params) do
    students = Repo.all(Student)
    render(conn, "index.html", students: students)
  end

  def new(conn, _params) do
    changeset = Student.changeset(%Student{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"student" => student_params}) do
    changeset = Student.changeset(%Student{}, student_params)

    case Repo.insert(changeset) do
      {:ok, _student} ->
        conn
        |> put_flash(:info, "Student created successfully.")
        |> redirect(to: student_path(conn, :index))
      {:error, changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    student = Repo.get!(Student, id)
    render(conn, "show.html", student: student)
  end

  def edit(conn, %{"id" => id}) do
    student = Repo.get!(Student, id)
    changeset = Student.changeset(student)
    render(conn, "edit.html", student: student, changeset: changeset)
  end

  def update(conn, %{"id" => id, "student" => student_params}) do
    student = Repo.get!(Student, id)
    changeset = Student.changeset(student, student_params)

    case Repo.update(changeset) do
      {:ok, student} ->
        conn
        |> put_flash(:info, "Student updated successfully.")
        |> redirect(to: student_path(conn, :show, student))
      {:error, changeset} ->
        render(conn, "edit.html", student: student, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    student = Repo.get!(Student, id)

    # Here we use delete! (with a bang) because we expect
    # it to always work (and if it does not, it will raise).
    Repo.delete!(student)

    conn
    |> put_flash(:info, "Student deleted successfully.")
    |> redirect(to: student_path(conn, :index))
  end

  def admin_authentication(conn, _) do
    if get_session(conn, :current_student) do
      student_id = get_session(conn, :current_student)
      student = Repo.get(Student, student_id)
      if student.email == "admineventScheduler@gmail.com" do
        conn
      else
        conn
          |> put_flash(:error, "You do not have admin rights")
          |> redirect(to: page_path(conn, :index))
          |> halt()
      end
    else
      conn
        |> put_flash(:error, "please log in")
        |> redirect(to: page_path(conn, :index))
    end
  end
end
