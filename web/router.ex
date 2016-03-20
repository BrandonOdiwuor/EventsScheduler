defmodule EventsScheduler.Router do
  use EventsScheduler.Web, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", EventsScheduler do
    pipe_through :browser # Use the default browser stack

    get "/", PageController, :index

    resources "/students", StudentController do
      resources "/events", EventController
    end

    resources "/sessions", SessionController, only: [:new, :create]

    delete "/logout", AuthenticationController, :delete
    get "/index", AuthenticationController, :index
    get "/event", AuthenticationController, :show
  end

  # Other scopes may use custom stacks.
  # scope "/api", EventsScheduler do
  #   pipe_through :api
  # end
end
