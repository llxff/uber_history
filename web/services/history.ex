defmodule History do
  require Logger

  defstruct client: nil, offset: 0, from: nil, to: nil

  @limit 20


  def weeks_ago(client, weeks_ago) do
    Logger.debug "Loading history for #{ weeks_ago } week ago"

    from = beginning_of_week(weeks_ago)
    to = end_of_week(weeks_ago)

    %History{client: client, from: from, to: to}
  end

  def load(history, all \\ []) do
    history.client
    |> Uber.Api.history(history.offset, @limit)
    |> Map.fetch!("history")
    |> do_load(all, history)
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
end
