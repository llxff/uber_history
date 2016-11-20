defmodule UberHistory.Receipt do
  use UberHistory.Web, :model

  @fields [
    :request_id,
    :subtotal,
    :total_charged,
    :total_owed,
    :total_fare,
    :currency_code,
    :duration,
    :distance,
    :distance_label
  ]

  @derive { Poison.Encoder, only: @fields }

  schema "receipts" do
    field :request_id, Ecto.UUID
    field :subtotal, :string
    field :total_charged, :string
    field :total_owed, :string
    field :total_fare, :string
    field :currency_code, :string
    field :duration, :string
    field :distance, :string
    field :distance_label, :string
  end

  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, @fields)
    |> validate_required([:request_id, :total_charged])
  end
end
