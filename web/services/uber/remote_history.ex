defmodule RemoteHistory do
  @limit 20

  def load(query) do
    load_from_uber([], query, 0)
  end

  defp load_from_uber(all, query, offset) do
    query.client
    |> Uber.Api.history(offset, @limit)
    |> Map.fetch!("history")
    |> collect(all, query, offset)
  end

  defp collect([], all, _query, _offset), do: all

  defp collect(rides, all, query, offset) do
    earliest_ride = List.first(rides)

    if earliest_ride["request_time"] < query.from do
      all
    else
      rides
      |> filter_rides(query)
      |> Enum.concat(all)
      |> load_from_uber(query, offset + @limit)
    end
  end

  defp filter_rides(rides, query) do
    rides
    |> Stream.filter(fn r -> on_this_week?(query, r) end)
    |> Stream.map(fn r -> Map.put(r, "rider_id", query.rider_id) end)
    |> Enum.to_list
  end

  defp on_this_week?(query, ride) do
    Enum.member?(query.from..query.to, ride["request_time"])
  end
end
