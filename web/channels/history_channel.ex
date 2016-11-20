defmodule UberHistory.HistoryChannel do
  require Logger
  use UberHistory.Web, :channel

  alias Uber.{Api, OAuth}
  alias UberHistory.{Repo, Receipt}

  def join("history", _params, socket) do
    {:ok, %{history: history(socket, 0), weeks_ago: 0}, socket}
  end

  def handle_in("receipt:load", %{"request_id" => request_id}, socket) do
    rec = receipt(socket, request_id)

    push socket, "receipt:loaded", %{request_id: request_id, receipt: rec}

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
    |> History.weeks_ago(socket.assigns.uuid, weeks_ago)
    |> History.load
  end

  defp receipt(socket, request_id) do
    case Repo.get_by(Receipt, request_id: request_id) do
      nil ->
        Logger.debug("Load and save receipt #{ request_id }")

        load_and_save_receipt(socket, request_id)
      receipt ->
        Logger.debug("Using saved receipt #{ request_id }")

        receipt
    end
  end

  defp load_and_save_receipt(socket, request_id) do
    receipt = socket
      |> client
      |> Api.receipt(request_id)

    changeset = Receipt.changeset(%Receipt{}, receipt)

    case Repo.insert(changeset) do
      {:ok, _saved_receipt} ->
        receipt
      {:error, _changeset} ->
        Logger.debug("Error happened during save #{ request_id }")

        receipt
    end
  end
end
