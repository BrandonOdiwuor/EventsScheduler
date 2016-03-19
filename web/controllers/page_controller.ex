defmodule EventsScheduler.PageController do
  use EventsScheduler.Web, :controller

  def index(conn, _params) do
    render conn, "index.html"
  end
end
