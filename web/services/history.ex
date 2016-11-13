defmodule History do
  defstruct client: nil, offset: 0, time_range: nil

  @limit 5

  def current_week(client) do
    today = Timex.local
    from = today |> Timex.beginning_of_week |> Timex.to_unix
    to = today |> Timex.end_of_week |> Timex.to_unix

    %History{client: client, time_range: from..to}
  end

  def load(history, all \\ []) do
    history.client
    |> Uber.Api.history(history.offset, @limit)
    |> Map.fetch!("history")
    |> Enum.filter(fn ride -> on_this_week?(history, ride) end)
    |> do_load(all, history)
  end

  defp on_this_week?(history, ride) do
    Enum.member?(history.time_range, ride["request_time"])
  end

  defp do_load([], all, _history) do
    all
  end

  defp do_load(rides, all, _history) when length(rides) < @limit do
    all ++ rides
  end

  defp do_load(rides, all, history) do
    history
    |> increase_offset
    |> load(all ++ rides)
  end

  defp increase_offset(history) do
    new_offset = history.offset + @limit

    %History{ history | offset: new_offset}
  end
end
