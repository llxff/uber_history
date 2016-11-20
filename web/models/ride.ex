defmodule UberHistory.Ride do
  use UberHistory.Web, :model

  @required_fields [
    :rider_id,
    :status,
    :distance,
    :product_id,
    :start_time,
    :end_time,
    :request_id,
    :request_time
  ]

  @derive { Poison.Encoder, only: @required_fields }

  schema "rides" do
    field :rider_id, Ecto.UUID
    field :status, :string
    field :distance, :float
    field :product_id, Ecto.UUID
    field :start_time, :integer
    field :end_time, :integer
    field :request_id, Ecto.UUID
    field :request_time, :integer
  end

  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, @required_fields)
    |> validate_required(@required_fields)
  end

  def required_fields, do: @required_fields
end
