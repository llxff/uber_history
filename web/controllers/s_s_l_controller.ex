defmodule UberHistory.SSLController do
  use UberHistory.Web, :controller

  def index(conn, _params) do
    conn
    |> put_status(:ok)
    |> text("vd93EcR4zirDOteHXk_AhAqPbIiEFsvFV8PiWkJcp5E.dKGx3qk71ICwaGVHtROF_8urSZRWv6WpDNhBQNk92V4")
  end
end
