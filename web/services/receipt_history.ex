defmodule ReceiptHistory do
  alias Uber.Api
  alias UberHistory.{Repo, Receipt}

  def load(client, request_id) do
    case Repo.get_by(Receipt, request_id: request_id) do
      nil ->
        load_and_save_receipt(client, request_id)
      receipt ->
        receipt
    end
  end

  defp load_and_save_receipt(client, request_id) do
    changeset = client
      |> Api.receipt(request_id)
      |> Receipt.new_changeset

    {:ok, receipt } = Repo.insert(changeset)

    receipt
  end
end
