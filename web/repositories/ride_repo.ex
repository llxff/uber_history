defmodule UberHistory.RideRepo do
  alias UberHistory.{Ride, Repo}

  import Ecto.Query, only: [from: 2]

  def of_period(rider_id, from, to) do
    query = from r in Ride,
      where: ^from <= r.request_time and r.request_time <= ^to and r.rider_id == ^rider_id,
      order_by: [desc: r.request_time],
      select: r

    Repo.all(query)
  end

  def insert_all(rides) do
    changeset = Enum.map(rides, &atomify_map/1)

    Repo.insert_all(Ride, changeset)
  end

  defp atomify_map(map) do
    map
    |> Enum.reduce(%{}, fn ({key, val}, acc) -> Map.put(acc, String.to_atom(key), val) end)
    |> Map.take(Ride.required_fields)
  end
end
