defmodule UberHistory.Router do
  use UberHistory.Web, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
    plug :assign_current_user
  end

  scope "/", UberHistory do
    pipe_through :browser # Use the default browser stack

    get "/", PageController, :index
  end

  scope "/auth", UberHistory do
    pipe_through :browser

    get "/", AuthController, :index
    get "/callback", AuthController, :callback
    delete "/logout", AuthController, :delete
  end

  defp assign_current_user(conn, _) do
    assign(conn, :current_user, get_session(conn, :current_user))
  end
end
