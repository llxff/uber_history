defmodule UberHistory.OAuth do
  use OAuth2.Strategy

  @client_id Application.get_env(:uber, :client_id)
  @client_secret Application.get_env(:uber, :client_secret)
  @redirect_uri Application.get_env(:uber, :redirect_uri)
  @site Application.get_env(:uber, :site)
  @authorize_url Application.get_env(:uber, :authorize_url)
  @token_url Application.get_env(:uber, :token_url)
  @scope Application.get_env(:uber, :scope)

  def client do
    OAuth2.Client.new([
      strategy: __MODULE__,
      client_id: @client_id,
      client_secret: @client_secret,
      redirect_uri: @redirect_uri,
      site: @site,
      authorize_url: @authorize_url,
      token_url: @token_url
    ])
  end

  def authorize_url! do
    OAuth2.Client.authorize_url!(client(), scope: @scope)
  end

  def get_token!(params \\ [], headers \\ [], opts \\ []) do
    OAuth2.Client.get_token!(client(), params, headers, opts)
  end

  def authorize_url(client, params) do
    OAuth2.Strategy.AuthCode.authorize_url(client, params)
  end

  def get_token(client, params, headers) do
    client
    |> put_param(:client_secret, client.client_secret)
    |> put_header("accept", "application/json")
    |> OAuth2.Strategy.AuthCode.get_token(params, headers)
  end

  def me(client) do
    OAuth2.Client.get!(client, "/v1/me")
  end
end
