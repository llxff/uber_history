defmodule UberHistory.PageController do
  use UberHistory.Web, :controller

  def index(conn, _params) do
    render conn, "index.html", token: get_session(conn, :access_token)
  end

  def cp(conn, _params) do
    render conn, "cp.html"
  end
end
