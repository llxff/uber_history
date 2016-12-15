defmodule UberHistory.SSLController do
  use UberHistory.Web, :controller

  def index(conn, _params) do
    conn
    |> put_status(:ok)
    |> text("4gERNJbL0LVMsDI5_DQxmXmoTgfD4vnnZbekWoIB_74.dKGx3qk71ICwaGVHtROF_8urSZRWv6WpDNhBQNk92V4")
  end
end
