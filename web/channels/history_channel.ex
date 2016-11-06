defmodule UberHistory.HistoryChannel do
  use UberHistory.Web, :channel

  alias Uber.Api

  def join("history", _params, socket) do
    history = socket |> client |> History.current_week |> History.load

    {:ok, %{history: history}, socket}
  end

  def handle_in("receipt:load", %{"request_id" => request_id}, socket) do
    ride = socket
      |> client
      |> Api.receipt(request_id)

    push socket, "receipt:loaded", %{ request_id: request_id, receipt: ride }

    {:noreply, socket}
  end

  defp client(socket), do: Uber.OAuth.client(socket.assigns.token)
end
