defmodule UberHistory.Router do
  use UberHistory.Web, :router

  pipeline :api do
    plug :accepts, ["json"]
    plug :put_secure_browser_headers
    plug :assign_uber_client
  end

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  defp assign_uber_client(conn, _) do
    token = get_req_header(conn, "authorization") |> fetch_token
    client = Uber.OAuth.client(token)

    assign(conn, :oauth_client, client)
  end

  defp fetch_token([token]), do: token
  defp fetch_token(_), do: nil

  scope "/auth", UberHistory do
    pipe_through :browser

    get "/", AuthController, :index
    get "/callback", AuthController, :callback
    delete "/logout", AuthController, :delete
  end

  scope "/api", UberHistory do
    pipe_through :api

    scope "/v1" do
      get "/current_user", CurrentUserController, :show
    end
  end

  scope "/", UberHistory do
    pipe_through :browser

    get "/.well-known/acme-challenge/WUsPdyouqxX0Zw0EsoWw7hQfSYtVYuAa09HsX7HdQHw", SSLController, :index
    get "/*path", PageController, :index
  end
end
