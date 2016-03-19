defmodule EventsScheduler.AuthenticationController do
  use EventsScheduler.Web, :controller

  def delete(conn, _params) do
    conn
    |> delete_session(:current_student)
    |> put_flash(:info, "Signed out successfully!")
    |> redirect(to: page_path(conn, :index))
  end
end
