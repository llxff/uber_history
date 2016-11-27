defmodule ReceiptHistory do
  alias Uber.Api
  alias UberHistory.{Repo, Receipt}

  def load(client, request_id, rider_id) do
    case Repo.get_by(Receipt, request_id: request_id) do
      nil ->
        load_and_save_receipt(client, request_id, rider_id)
      receipt ->
        receipt
    end
  end

  defp load_and_save_receipt(client, request_id, rider_id) do
    uber_receipt = Api.receipt(client, request_id)
    changeset = Receipt.changeset(%Receipt{rider_id: rider_id}, uber_receipt)

    {:ok, receipt } = Repo.insert(changeset)

    receipt
  end
end
