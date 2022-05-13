# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :phoenix_library,
  ecto_repos: [PhoenixLibrary.Repo],
  generators: [binary_id: true]

# Configures the endpoint
config :phoenix_library, PhoenixLibraryWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "k+w5PhxlKig5B3ehJvsghUMSAYLniDkZUzJfDWNFoB4R/m8Xdk7q13iMH5CuNhdx",
  render_errors: [view: PhoenixLibraryWeb.ErrorView, accepts: ~w(json), layout: false],
  pubsub_server: PhoenixLibrary.PubSub,
  live_view: [signing_salt: "1jjMInq5"]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
