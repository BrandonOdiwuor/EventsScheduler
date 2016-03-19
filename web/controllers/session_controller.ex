defmodule EventsScheduler.SessionController do
  use EventsScheduler.Web, :controller
  alias EventsScheduler.Student
  import Comeonin.Bcrypt, only: [checkpw: 2]

  plug :scrub_params, "session" when action in [:create]

  def new(conn, _params) do
    render conn, :new
  end

  def create(conn, %{"session" => student_params}) do
    Repo.get_by(Student, email: student_params["email"])
      |> sign_in(student_params["password"], conn)
  end


  defp sign_in(student, password, conn) when is_nil(student) do
    conn
      |> put_flash(:error, "Email not registered, please check email")
      |> redirect(to: session_path(conn, :new))
  end

  defp sign_in(student, password, conn) do
    if checkpw(password, student.encrypted_password) do
      conn
        |> put_session(:current_student, student.id)
        |> put_flash(:info, "Sign in sucessfull")
        |> redirect(to: page_path(conn, :index))
    else
      conn
        |> put_flash(:error, "Invalid email/password combination!")
        |> redirect(to: session_path(conn, :new))
    end
  end

end
