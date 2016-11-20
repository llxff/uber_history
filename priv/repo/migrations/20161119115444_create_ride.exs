defmodule UberHistory.Repo.Migrations.CreateRide do
  use Ecto.Migration

  def change do
    create table(:rides) do
      add :rider_id, :uuid
      add :status, :string
      add :distance, :float
      add :product_id, :uuid
      add :start_time, :integer
      add :end_time, :integer
      add :request_id, :uuid
      add :request_time, :integer
    end

    create index(:rides, [:rider_id, :request_time])
  end
end
