defmodule MongoToPostgres.Mongo.Repo do
    use Ecto.Repo,
        otp_app: :mongo_to_postgres,
        adapter: Mongo.Ecto
end

defmodule MongoToPostgres.Mongo.User do
    use Ecto.Model

    @primary_key {:id, :string, autogenerate: false}
    schema "User" do
        field :Name
        embeds_many :Activities, MongoToPostgres.Mongo.Activity
    end
end

defmodule MongoToPostgres.Mongo.Activity do
    use Ecto.Model

    @primary_key {:id, :string, autogenerate: false}
    schema "Activity" do
        field :Name
        field :Hours
        embeds_many :Records, MongoToPostgres.Mongo.Record
    end
end

defmodule MongoToPostgres.Mongo.Record do
    use Ecto.Model

    @primary_key{:id, :string, autogenerate: false}
    schema "Record" do
        field :Note
        field :Time
        field :Date, Ecto.DateTime
    end
end

defmodule MongoToPostgres.Mongo.Migration do
    import Ecto.Query
    import MongoToPostgres.Mongo.Repo

    alias MongoToPostgres.Mongo.User
    alias MongoToPostgres.Mongo.Repo

    def user_query do
        query = from u in User,
            select: u

        MongoToPostgres.Mongo.Repo.all(query)
        |> Enum.reject(fn record -> Enum.count(record."Activities") == 0 end)
        |> Enum.map(fn user ->
            u = %MongoToPostgres.User{oauth_token: user.id, name: user."Name"}

            {:ok, newUser} = MongoToPostgres.Repo.insert(u)

            user."Activities"
            |> Enum.map(fn act ->
                    case act."Hours" do
                        "" -> hours = 1.0
                        nil -> hours = 1.0
                        _ -> {hours, _} = Float.parse(act."Hours")
                    end

                    a = %MongoToPostgres.Activity{user_id: newUser.id, name: act."Name", default_duration: hours}
                    {:ok, activity} = MongoToPostgres.Repo.insert(a)

                    act."Records"
                    |> Enum.map(fn rec ->
                            case rec."Time" do
                                "" -> time = 1.0
                                nil -> time = 1.0
                                _ -> {time, _} = Float.parse(rec."Time")
                            end

                            r = %MongoToPostgres.Record{activity_id: activity.id, note: rec."Note", date: rec."Date", duration: time}
                            MongoToPostgres.Repo.insert(r)
                        end)
                end)
            end)

    end
end