defmodule EventsScheduler.SessionController do
  use EventsScheduler.Web, :controller
  alias EventsScheduler.Student
  import Comeonin.Bcrypt, only: [checkpw: 2]

  plug :scrub_params, "session" when action in [:create]

  def new(conn, _params) do
    render conn, :new
  end

  def create(conn, %{"session" => %{"email" => email, "password" => password}}) when not is_nil(email) and  not is_nil(password)do
    Repo.get_by(Student, email: email)
      |> sign_in(password, conn)
  end

  def create(conn, _) do
    failed_login(conn)
  end


  defp sign_in(student, password, conn) when is_nil(student) do
    conn
      |> put_flash(:error, "Email not registered, please correct email or sign up")
      |> redirect(to: student_path(conn, :new))
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
        |> redirect(to: student_path(conn, :new))
    end
  end

  defp failed_login(conn) do
    conn
      |> put_flash(:error, "email or password cannot be empty")
      |> redirect(to: session_path(conn, :new))

  end

end
