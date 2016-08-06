defmodule MongoToPostgres.Repo do
  use Ecto.Repo, otp_app: :mongo_to_postgres
end

defmodule MongoToPostgres.User do
  use Ecto.Model
  
  schema "users" do
    field :oauth_token, :string
    field :name, :string

    has_many :activities, MongoToPostgres.Activity
  end
end

defmodule MongoToPostgres.Activity do
  use Ecto.Model

  schema "activities" do
      field :name, :string
      field :default_duration, :float

      field :user_id, :integer

      has_many :records, MongoToPostgres.Record
  end
end

defmodule MongoToPostgres.Record do
  use Ecto.Model

  schema "records" do
    field :note, :string
    field :duration, :float
    field :date, Ecto.DateTime

    field :activity_id, :integer
  end
end