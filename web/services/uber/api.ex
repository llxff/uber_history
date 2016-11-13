defmodule Uber.Api do
  alias OAuth2.{Client, Response}

  def me(client) do
    Client.get!(client, "/v1/me") |> response
  end

  def history(client, offset \\ 0, limit \\ 14) do
    Client.get!(client, "/v1.2/history?offset=#{ offset }&limit=#{ limit }") |> response
  end

  def receipt(client, request_id) do
    Client.get!(client, "/v1/requests/#{ request_id }/receipt") |> response
  end

  defp response(%Response{body: %{"code" => "unauthorized"}}), do: nil
  defp response(%Response{body: body}), do: body
end
