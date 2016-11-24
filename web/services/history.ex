defmodule History do
  alias UberHistory.RideRepo

  def load(query) do
    load(query, query.weeks_ago)
  end

  def load(query, 0), do: RemoteHistory.load(query)

  def load(query, _weeks_ago) do
    case RideRepo.of_period(query.rider_id, query.from, query.to) do
      [] ->
        query
        |> RemoteHistory.load
        |> save
      rides ->
        rides
     end
  end

  defp save(rides) do
    RideRepo.insert_all(rides)

    rides
  end
end
