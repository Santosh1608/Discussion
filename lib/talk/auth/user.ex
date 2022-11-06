defmodule Talk.Auth.User do
  use Ecto.Schema
  import Ecto.Changeset
  alias Talk.Posts.Topic
  alias Talk.Posts.Comment

  @derive {Jason.Encoder, only: [:email, :name]}

  schema "users" do
    field :name, :string
    field :email, :string
    field :token, :string
    has_many :topics, Topic
    has_many :comment, Comment
    timestamps()
  end

  @doc false
  def changeset(topic, attrs \\ %{}) do
    topic
    |> cast(attrs, [:name,:email,:token])
    |> validate_required([:name,:email,:token])
  end
end
