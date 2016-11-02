defmodule UberHistory.HistoryChannel do
  use UberHistory.Web, :channel

  def join("history", _params, socket) do
    client = Uber.OAuth.client(socket.assigns.token)
    history = Uber.Api.history(client)

    {:ok, %{history: history}, socket}
  end
end
