defmodule Talk.Posts.Topic do
  use Ecto.Schema
  import Ecto.Changeset
  alias Talk.Auth.User
  alias Talk.Posts.Comment
  schema "topics" do
    field :title, :string
    belongs_to(:user, User)
    has_many :comments, Comment
    timestamps()
  end

  @doc false
  def changeset(topic, attrs \\ %{}) do
    topic
    |> cast(attrs, [:title])
    |> validate_required([:title])
  end
end
