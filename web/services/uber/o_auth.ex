defmodule Uber.OAuth do
  alias OAuth2.{Strategy, Strategy.AuthCode, Client}

  use Strategy

  def config do
    [
      strategy: __MODULE__,
      client_id: Application.get_env(:uber, :client_id),
      client_secret: Application.get_env(:uber, :client_secret),
      redirect_uri: Application.get_env(:uber, :redirect_uri),
      site: Application.get_env(:uber, :site),
      authorize_url: Application.get_env(:uber, :authorize_url),
      token_url: Application.get_env(:uber, :token_url)
    ]
  end

  def client do
    Client.new(config)
  end

  def client(token) do
    Client.new(config ++ [token: token])
  end

  def authorize_url! do
    Client.authorize_url!(client(), scope: Application.get_env(:uber, :scope))
  end

  def get_token!(params \\ [], headers \\ [], opts \\ []) do
    Client.get_token!(client(), params, headers, opts)
  end

  def authorize_url(client, params) do
    AuthCode.authorize_url(client, params)
  end

  def get_token(client, params, headers) do
    client
    |> put_param(:client_secret, client.client_secret)
    |> put_header("accept", "application/json")
    |> AuthCode.get_token(params, headers)
  end
end
