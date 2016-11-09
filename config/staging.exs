use Mix.Config

config :mongo_to_postgres, MongoToPostgres.Repo,
  adapter: Ecto.Adapters.Postgres,
  url: "postgres://azbcmwlweerphc:X0y9zt55ngBGz160u8cBgM3tlB@ec2-174-129-37-103.compute-1.amazonaws.com:5432/dctpo8rh50hmbo",
  pool_size: String.to_integer(System.get_env("POOL_SIZE") || "10"),
  ssl: true


config :mongo_to_postgres, MongoToPostgres.Mongo.Repo,
    url: "mongodb://elixir:2WmKdCVTB4uA41Az45RN9gI9K@ds047197.mlab.com:47197/subtleostrich"