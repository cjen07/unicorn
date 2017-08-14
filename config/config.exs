# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
use Mix.Config

config :unicorn, path: "./"

config :unicorn, ecto_repos: [Unicorn.Repo]

config :unicorn, Unicorn.Repo,
  adapter: Ecto.Adapters.Postgres,
  username: "postgres",
  password: "postgres",
  database: "unicorn",
  hostname: "localhost",
  pool_size: 10
