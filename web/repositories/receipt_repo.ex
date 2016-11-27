defmodule UberHistory.ReceiptRepo do
  alias UberHistory.{Receipt, Repo}

  import Ecto.Query, only: [from: 2]

  def delete_of_rider(rider_id) do
    from(r in Receipt, where: r.rider_id == ^rider_id)
    |> Repo.delete_all
  end
end
