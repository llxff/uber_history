defmodule UberHistory.PageController do
  use UberHistory.Web, :controller

  alias UberHistory.Api

  def index(conn, _params) do
    current_user = Api.me(conn.assigns[:oauth_client])

    render conn, "index.html", current_user: current_user
  end
end
