defmodule MongoToPostgres.Repo.Migrations.CreateUser do
  use Ecto.Migration

  def change do
    create table(:users) do
      add :oauth_token, :string, size: 50
      add :name, :string, size: 100
    end

    create table(:activities) do
      add :name, :string, size: 100
      add :default_duration, :float

      add :user_id, :integer
    end

    create table(:records) do
      add :note, :text
      add :duration, :float
      add :date, :datetime

      add :activity_id, :integer
    end
  end
end
