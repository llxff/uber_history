defmodule UberHistory.HistoryChannel do
  require Logger
  use UberHistory.Web, :channel

  alias Uber.OAuth
  alias History.Query

  def join("history", _params, socket) do
    {:ok, %{history: history(socket, 0), weeks_ago: 0}, socket}
  end

  def handle_in("receipt:load", %{"request_id" => request_id}, socket) do
    receipt = socket
      |> client
      |> ReceiptHistory.load(request_id, socket.assigns.uuid)

    push socket, "receipt:loaded", %{request_id: request_id, receipt: receipt}

    {:noreply, socket}
  end

  def handle_in("history:load", %{"weeks_ago" => weeks_ago}, socket) do
    history = history(socket, weeks_ago)

    push socket, "history:loaded", %{history: history, weeks_ago: weeks_ago}

    {:noreply, socket}
  end

  defp client(socket), do: OAuth.client(socket.assigns.token)

  defp history(socket, weeks_ago) do
    socket
    |> client
    |> Query.weeks_ago(socket.assigns.uuid, weeks_ago)
    |> History.load
  end
end
