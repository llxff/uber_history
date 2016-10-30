defmodule UberHistory.AuthController do
  use UberHistory.Web, :controller

  alias Uber.OAuth

  def index(conn, _params) do
    redirect conn, external: OAuth.authorize_url!
  end

  def delete(conn, _params) do
    conn
    |> put_flash(:info, "You have been logged out!")
    |> configure_session(drop: true)
    |> redirect(to: "/")
  end

  def callback(conn, %{"code" => code}) do
    client = OAuth.get_token!(code: code)

    conn
    |> put_session(:access_token, client.token.access_token)
    |> redirect(to: "/")
  end
end
