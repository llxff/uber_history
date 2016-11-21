defmodule History.Query do
  defstruct client: nil, rider_id: nil, from: nil, to: nil, weeks_ago: 0

  def weeks_ago(client, rider_id, weeks_ago) do
    from = beginning_of_week(weeks_ago)
    to = end_of_week(weeks_ago)

    %History.Query{client: client, rider_id: rider_id, from: from, to: to, weeks_ago: weeks_ago}
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
end
