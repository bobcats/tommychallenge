# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# General application configuration
config :tommychallenge,
  ecto_repos: [Tommychallenge.Repo]

# Configures the endpoint
config :tommychallenge, Tommychallenge.Web.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "RtwcSw7rohD6vhgH99+jUTv+5bKBiHwkof6OT3ddbieJlGn4/Pl//huyeZe4hofJ",
  render_errors: [view: Tommychallenge.Web.ErrorView, accepts: ~w(json)],
  pubsub: [name: Tommychallenge.PubSub,
           adapter: Phoenix.PubSub.PG2]

config :tommychallenge, :random_words_client, RandomWords.Word
config :tommychallenge, :spotify_client, Spotify.HTTP

config :tommychallenge,
  spotify_client_id: System.get_env("SPOTIFY_CLIENT_ID"),
  spotify_client_secret: System.get_env("SPOTIFY_CLIENT_SECRET")

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"
