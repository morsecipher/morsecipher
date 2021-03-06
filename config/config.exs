# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :morsecipher,
  ecto_repos: [Morsecipher.Repo]

# Configures the endpoint
config :morsecipher, MorsecipherWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "+Mz81grbcozhwKHtY4N27o06FnmXY4cmGJiItKiW01wINh9kOGJoNJBt6j8RiuJY",
  render_errors: [view: MorsecipherWeb.ErrorView, accepts: ~w(html json), layout: false],
  pubsub_server: Morsecipher.PubSub,
  live_view: [signing_salt: "m1xSpr70"]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

config :cors_plug,
  origin: ["*"],
  max_age: 86400,
  methods: ["GET", "POST", "OPTION"]

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
