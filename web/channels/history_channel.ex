defmodule UberHistory.HistoryChannel do
  use UberHistory.Web, :channel

  alias Uber.{Api, OAuth}

  def join("history", _params, socket) do
    {:ok, %{history: history(socket, 0), weeks_ago: 0}, socket}
  end

  def handle_in("receipt:load", %{"request_id" => request_id}, socket) do
    ride = socket
      |> client
      |> Api.receipt(request_id)

    push socket, "receipt:loaded", %{request_id: request_id, receipt: ride}

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
    |> History.weeks_ago(weeks_ago)
    |> History.load
  end
end
