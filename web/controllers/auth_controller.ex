defmodule UberHistory.AuthController do
  use UberHistory.Web, :controller

  def index(conn, _params) do
    redirect conn, external: UberHistory.OAuth.authorize_url!
  end

  def delete(conn, _params) do
    conn
    |> put_flash(:info, "You have been logged out!")
    |> configure_session(drop: true)
    |> redirect(to: "/")
  end

  def callback(conn, %{"code" => code}) do
    client = UberHistory.OAuth.get_token!(code: code)

    %{body: user} = UberHistory.OAuth.me(client)

    IO.inspect user

    conn
    |> put_session(:current_user, user)
    |> put_session(:access_token, client.token.access_token)
    |> redirect(to: "/")
  end
end
