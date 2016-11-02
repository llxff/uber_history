defmodule UberHistory.HistoryChannel do
  use UberHistory.Web, :channel

  alias Uber.Api

  def join("history", _params, socket) do
    history = socket
      |> client
      |> Api.history

    {:ok, %{history: history}, socket}
  end

  def handle_in("receipt:load", %{"request_id" => request_id}, socket) do
    ride = socket
      |> client
      |> Api.receipt(request_id)

    broadcast! socket, "receipt:loaded", %{ request_id: request_id, receipt: ride }

    {:noreply, socket}
  end

  defp client(socket), do: Uber.OAuth.client(socket.assigns.token)
end
