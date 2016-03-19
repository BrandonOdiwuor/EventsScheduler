defmodule EventsScheduler.PageController do
  use EventsScheduler.Web, :controller
  alias EventsScheduler.Event

  def index(conn, _params) do
    events = Repo.all(Event)
    render conn, "index.html", events: events
  end
end
