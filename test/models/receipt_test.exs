defmodule UberHistory.ReceiptTest do
  use UberHistory.ModelCase

  alias UberHistory.Receipt

  @valid_attrs %{currency_code: "some content", distance: "some content", distance_label: "some content", duration: "some content", request_id: "7488a646-e31f-11e4-aace-600308960662", subtotal: "some content", total_charged: "some content", total_fare: "some content", total_owed: "some content"}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = Receipt.changeset(%Receipt{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = Receipt.changeset(%Receipt{}, @invalid_attrs)
    refute changeset.valid?
  end
end
