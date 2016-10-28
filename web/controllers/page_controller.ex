defmodule UberHistory.PageController do
  use UberHistory.Web, :controller

  alias UberHistory.Api

  def index(conn, _params) do
    client = conn.assigns[:oauth_client]
    current_user = Api.me(client)

    _index(conn, client, current_user)
  end

  defp _index(conn, _client, nil), do: render(conn, "index.html", current_user: nil)

  defp _index(conn, client, current_user) do
    history = Api.history(client)

    render conn, "index.html", current_user: current_user, history: history
  end
end
