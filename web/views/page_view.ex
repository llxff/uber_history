defmodule UberHistory.PageView do
  use UberHistory.Web, :view

  def from_timestamp(timestamp) do
    { :ok, time } = DateTime.from_unix(timestamp)
    DateTime.to_string(time)
  end
end
