defmodule UberHistory.Router do
  use UberHistory.Web, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
    plug :assign_uber_client
  end

  defp assign_uber_client(conn, _) do
    client = Uber.OAuth.client(get_session(conn, :access_token))
    assign(conn, :oauth_client, client)
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
end
