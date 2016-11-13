defmodule UberHistory.HistoryChannel do
  use UberHistory.Web, :channel

  alias Uber.{Api, OAuth}

  def join("history", _params, socket) do
    {:ok, %{history: history(0, socket), week: 0}, socket}
  end

  def handle_in("receipt:load", %{"request_id" => request_id}, socket) do
    ride = socket
      |> client
      |> Api.receipt(request_id)

    push socket, "receipt:loaded", %{request_id: request_id, receipt: ride}

    {:noreply, socket}
  end

  def handle_in("history:load", %{"week" => week}, socket) do
    history = history(week, socket)

    push socket, "history:loaded", %{history: history, week: week}

    {:noreply, socket}
  end

  defp client(socket), do: OAuth.client(socket.assigns.token)

  defp history(week, socket) do
    socket
    |> client
    |> History.week(week)
    |> History.load
  end
end
