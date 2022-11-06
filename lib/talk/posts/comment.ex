defmodule Talk.Posts.Comment do
    use Ecto.Schema
    import Ecto.Changeset
    alias Talk.Auth.User
    alias Talk.Posts.Topic

    @derive {Jason.Encoder, only: [:content, :user]}


    schema "comments" do
      field :content, :string
      belongs_to(:user, User)
      belongs_to(:topic, Topic)
      timestamps()
    end
  
    @doc false
    def changeset(topic, attrs \\ %{}) do
      topic
      |> cast(attrs, [:content])
      |> validate_required([:content])
    end
  end
  