# Uber History

How much do you spend with Uber?

To start application:

  * Install Javascript dependencies with `yarn install`
  * Copy configuration file with `cp config/dev.exs.example config/dev.exs`
  * Setup PostgreSQL connection in `config/dev.exs`
  * Setup Uber API credentials in `config/dev.exs`
  * Install Elixir dependencies with `mix deps.get`
  * Create and migrate your database with `mix ecto.create && mix ecto.migrate`
  * Start Phoenix endpoint with `mix phoenix.server`

Now you can visit [`localhost:4000`](http://localhost:4000) from your browser.

