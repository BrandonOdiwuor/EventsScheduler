defmodule EventsScheduler.AuthenticationController do
  use EventsScheduler.Web, :controller
  import Plug.Conn

  def delete(conn, _params) do
    conn
    |> delete_session(:current_student)
    |> put_flash(:info, "Signed out successfully!")
    |> redirect(to: page_path(conn, :index))
  end

  def index(conn, _params) do
    if get_session(conn, :current_student) do
      current_student = get_session(conn, :current_student)
      conn
        |> redirect(to: student_event_path(conn, :index, current_student))
    else
      conn
        |> put_flash(:error, "you must be logged in to view this page")
        |> redirect(to: page_path(conn, :index))
    end
  end
end
