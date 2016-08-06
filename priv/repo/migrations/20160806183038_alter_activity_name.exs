defmodule MongoToPostgres.Repo.Migrations.AlterActivityName do
  use Ecto.Migration

  def change do
    alter table(:activities) do
      modify :name, :text
    end
  end
end
