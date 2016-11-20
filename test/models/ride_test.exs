defmodule UberHistory.RideTest do
  use UberHistory.ModelCase

  alias UberHistory.Ride

  @valid_attrs %{distance: "120.5", end_time: 42, product_id: "7488a646-e31f-11e4-aace-600308960662", request_id: "7488a646-e31f-11e4-aace-600308960662", request_time: 42, rider_id: "some content", start_time: 42, status: "some content"}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = Ride.changeset(%Ride{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = Ride.changeset(%Ride{}, @invalid_attrs)
    refute changeset.valid?
  end
end
