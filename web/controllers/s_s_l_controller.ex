defmodule UberHistory.SSLController do
  use UberHistory.Web, :controller

  def index(conn, _params) do
    conn
    |> put_status(:ok)
    |> text("4kKI0ZvdfJlp980lKGt_uT5nSLbkao_2tv3vkJSXeVE.dKGx3qk71ICwaGVHtROF_8urSZRWv6WpDNhBQNk92V4")
  end
end
