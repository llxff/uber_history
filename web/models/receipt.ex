defmodule UberHistory.Receipt do
  alias UberHistory.Receipt

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

  def fields, do: @fields

  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, @fields)
    |> validate_required([:request_id, :total_charged])
  end

  def new_changeset(params) do
    changeset(%UberHistory.Receipt{}, params)
  end

  def encode_model(receipt) do
    Map.put(receipt, :total_charged_amount, total_charged_amount(receipt))
  end

  defp total_charged_amount(receipt) do
    receipt.total_charged
    |> Money.parse(receipt.currency_code)
    |> elem(1)
    |> Money.to_string(symbol: false, separator: "")
    |> String.to_float
  end

  defimpl Poison.Encoder, for: Receipt do
    def encode(receipt, options) do
      receipt
      |> Receipt.encode_model
      |> Map.take([:total_charged_amount | Receipt.fields])
      |> Poison.Encoder.Map.encode(options)
    end
  end
end
