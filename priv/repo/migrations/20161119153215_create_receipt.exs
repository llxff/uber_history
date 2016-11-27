defmodule UberHistory.Repo.Migrations.CreateReceipt do
  use Ecto.Migration

  def change do
    create table(:receipts) do
      add :request_id, :uuid
      add :rider_id, :uuid
      add :subtotal, :string
      add :total_charged, :string
      add :total_owed, :string
      add :total_fare, :string
      add :currency_code, :string
      add :duration, :string
      add :distance, :string
      add :distance_label, :string
    end

    create index(:receipts, [:request_id])
  end
end
