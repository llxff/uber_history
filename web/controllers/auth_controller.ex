defmodule UberHistory.AuthController do
  use UberHistory.Web, :controller

  alias Uber.{OAuth, Api}
  alias UberHistory.{ReceiptRepo, RideRepo}

  def index(conn, _params) do
    redirect conn, external: OAuth.authorize_url!
  end

  def delete(conn, _params) do
    user = conn
      |> get_session(:access_token)
      |> OAuth.client
      |> Api.me

    case user do
      nil ->
        logout(conn)
      %{"uuid" => rider_id} ->
        ReceiptRepo.delete_of_rider(rider_id)
        RideRepo.delete_of_rider(rider_id)

        logout(conn)
    end
  end

  def callback(conn, %{"code" => code}) do
    client = OAuth.get_token!(code: code)

    conn
    |> put_session(:access_token, client.token.access_token)
    |> redirect(to: "/")
  end

  def callback(conn, %{"error" => "invalid_scope"}) do
    conn
    |> put_flash(:error, "К сожалению, вы пока не можете использовать приложение 😭")
    |> redirect(to: "/")
  end

  defp logout(conn) do
    conn
    |> put_flash(:info, "You have been logged out!")
    |> configure_session(drop: true)
    |> redirect(to: "/")
  end
end
