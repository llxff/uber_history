defmodule History do
  defstruct client: nil, offset: 0, from: nil, to: nil

  @limit 14

  def new(client) do
    today = Timex.local
    from = today |> Timex.beginning_of_week |> Timex.to_unix
    to = today |> Timex.end_of_week |> Timex.to_unix

    %History{client: client, from: from, to: to}
  end

  def load(history, all \\ []) do
    rides = Uber.Api.history(history.client, history.offset, @limit)["history"]

    if less(history, List.first(rides)) do
      if more(history, List.last(rides)) do
        load(increase_offset(history), all ++ rides)
      else
        all ++ Enum.filter(rides, &(less(history, &1) && more(history, &1)))
      end
    else
      []
    end
  end

  defp less(_history, nil), do: false
  defp less(history, ride), do: ride["request_time"] <= history.to

  defp more(_history, nil), do: false
  defp more(history, ride), do: ride["request_time"] >= history.from

  defp increase_offset(history) do
    new_offset = history.offset + @limit

    %History{ history | offset: new_offset}
  end
end
