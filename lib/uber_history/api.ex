defmodule UberHistory.Api do
  def me(client) do
    response OAuth2.Client.get!(client, "/v1/me")
  end

  defp response(%OAuth2.Response{body: %{"code" => "unauthorized"}}), do: nil
  defp response(%OAuth2.Response{body: body}), do: body
end
