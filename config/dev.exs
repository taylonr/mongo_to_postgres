use Mix.Config

config :mongo_to_postgres, MongoToPostgres.Repo,
  adapter: Ecto.Adapters.Postgres,
  database: "couchjitsu_track_dev",
  username: "taylonr",
  password: "",
  hostname: "localhost"

config :mongo_to_postgres, MongoToPostgres.Mongo.Repo,
    url: "mongodb://elixir:2WmKdCVTB4uA41Az45RN9gI9K@ds047197.mlab.com:47197/subtleostrich"