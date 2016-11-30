use Mix.Config

config :uber_history, UberHistory.Endpoint,
  http: [port: {:system, "PORT"}],
  url: [host: "wiserider.ru"],
  cache_static_manifest: "priv/static/manifest.json",
  secret_key_base: System.get_env("SECRET_KEY_BASE")

config :logger, level: :info

config :uber_history, UberHistory.Repo,
  adapter: Ecto.Adapters.Postgres,
  url: System.get_env("DATABASE_URL"),
  pool_size: String.to_integer(System.get_env("POOL_SIZE") || "10"),
  ssl: true

config :uber,
  client_id: System.get_env("UBER_CLIENT_ID"),
  client_secret: System.get_env("UBER_CLIENT_SECRET"),
  scope: "profile history request_receipt",
  redirect_uri: "https://wiserider.herokuapp.com/auth/callback",
  site: "https://sandbox-api.uber.com",
  authorize_url: "https://login.uber.com/oauth/v2/authorize",
  token_url: "https://login.uber.com/oauth/v2/token"
