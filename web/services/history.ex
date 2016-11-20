defmodule History do
  require Logger
  import Ecto.Query, only: [from: 2]

  alias UberHistory.{Ride, Repo}

  defstruct client: nil, uuid: nil, offset: 0, from: nil, to: nil, weeks_ago: 0

  @limit 20

  def weeks_ago(client, uuid, weeks_ago) do
    Logger.debug "Loading history for #{ weeks_ago } week ago"

    from = beginning_of_week(weeks_ago)
    to = end_of_week(weeks_ago)

    %History{client: client, uuid: uuid, from: from, to: to, weeks_ago: weeks_ago}
  end

  def load(history) do
    if history.weeks_ago == 0 do
      load(history, [])
    else
      case load_from_local_storage(history) do
        [] ->
          load(history, []) |> save_into_local_storage(history.uuid)
        rides ->
          rides
       end
    end
  end

  def load(history, all) do
    history.client
    |> Uber.Api.history(history.offset, @limit)
    |> Map.fetch!("history")
    |> do_load(all, history)
  end

  defp load_from_local_storage(history) do
    query = from r in Ride,
      where: ^history.from <= r.request_time and r.request_time <= ^history.to and r.rider_id == ^history.uuid,
      order_by: [desc: r.request_time],
      select: r

    Repo.all(query)
  end

  defp do_load([], all, _history) do
    Logger.debug "Empty list of rides"

    all
  end

  defp do_load(rides, all, history) do
    latest_ride = List.first(rides)
    earliest_ride = List.last(rides)

    if earliest_ride["request_time"] <= history.to do
      if earliest_ride["request_time"] >= history.from do
        if latest_ride["request_time"] <= history.to do
          Logger.debug "Add all #{ Enum.count(rides) } rides and load more"

          load_more(history, all ++ rides)
        else
          Logger.debug "Filter #{ Enum.count(rides) } rides and load more"

          load_more(history, all ++ filter_rides(rides, history))
        end
      else
        Logger.debug "Filter #{ Enum.count(rides) } rides and finish"

        all ++ filter_rides(rides, history)
      end
    else
      Logger.debug "Skip #{ Enum.count(rides) } rides because of interval"

      load_more(history, all)
    end
  end

  defp beginning_of_week(weeks_ago) do
    week_ago(weeks_ago)
    |> Timex.beginning_of_week
    |> Timex.to_unix
  end

  defp end_of_week(weeks_ago) do
    week_ago(weeks_ago)
    |> Timex.end_of_week
    |> Timex.to_unix
  end

  defp week_ago(weeks_ago) do
    Timex.local
    |> Timex.shift(weeks: -weeks_ago)
  end

  defp on_this_week?(history, ride) do
    Enum.member?(history.from..history.to, ride["request_time"])
  end

  defp load_more(history, rides) do
    history
    |> increase_offset
    |> load(rides)
  end

  defp filter_rides(rides, history) do
    Enum.filter(rides, fn r -> on_this_week?(history, r) end)
  end

  defp increase_offset(history) do
    new_offset = history.offset + @limit

    %History{ history | offset: new_offset}
  end

  defp save_into_local_storage(rides, uuid) do
    changeset = rides |> Enum.map(&(atomify_map(&1, uuid)))

    Logger.debug "Save #{ Enum.count(rides) } rides into database"

    Repo.insert_all(Ride, changeset)

    rides
  end

  defp atomify_map(map, uuid) do
    map
    |> Enum.reduce(%{}, fn ({key, val}, acc) -> Map.put(acc, String.to_atom(key), val) end)
    |> Map.take(Ride.required_fields)
    |> Map.put(:rider_id, uuid)
  end
end
