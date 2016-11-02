defmodule Uber.Api do
  def me(client) do
    OAuth2.Client.get!(client, "/v1/me") |> response
  end

  def history(client) do
    response OAuth2.Client.get!(client, "/v1.2/history")
  end

  defp response(%OAuth2.Response{body: %{"code" => "unauthorized"}}), do: nil
  defp response(%OAuth2.Response{body: body}), do: body
end