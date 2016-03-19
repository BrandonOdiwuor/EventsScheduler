defmodule EventsScheduler.AuthenticationHelpers do
  use EventsScheduler.Web, :controller
  alias EventsScheduler.Student

  def current_student(conn) do
    id = Plug.Conn.get_session(conn, :current_student)
    if id, do: Repo.get(Student, id)
  end

  def logged_in?(conn), do: !!current_student(conn)
end
