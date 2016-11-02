defmodule UberHistory.CurrentUserController do
  use UberHistory.Web, :controller

  alias Uber.Api

  def show(conn, _) do
    client = conn.assigns[:oauth_client]
    user = Api.me(client)

    conn
    |> put_status(:ok)
    |> render("show.json", user: user)
  end
end
