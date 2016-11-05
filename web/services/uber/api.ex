defmodule Uber.Api do
  def me(client) do
    OAuth2.Client.get!(client, "/v1/me") |> response
  end

  def history(client, offset \\ 0, limit \\ 14) do
    OAuth2.Client.get!(client, "/v1.2/history?offset=#{ offset }&limit=#{ limit }") |> response
  end

  def receipt(client, request_id) do
    OAuth2.Client.get!(client, "/v1/requests/#{ request_id }/receipt") |> response
  end

  defp response(%OAuth2.Response{body: %{"code" => "unauthorized"}}), do: nil
  defp response(%OAuth2.Response{body: body}), do: body
end
