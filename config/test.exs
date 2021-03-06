use Mix.Config

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :tommychallenge, Tommychallenge.Web.Endpoint,
  http: [port: 4001],
  server: false

# Print only warnings and errors during test
config :logger, level: :warn

# Configure your database
config :tommychallenge, Tommychallenge.Repo,
  adapter: Ecto.Adapters.Postgres,
  username: "postgres",
  password: "postgres",
  database: "tommychallenge_test",
  hostname: "localhost",
  pool: Ecto.Adapters.SQL.Sandbox

config :tommychallenge, :random_words_client, RandomWords.Mock
config :tommychallenge, :spotify_client, Spotify.Mock

# Reduce encryption rounds to speed up tests.
config :comeonin, :pbkdf2_rounds, 1
