defmodule Talk.Repo.Migrations.CreateComments do
  use Ecto.Migration

  def change do
    create table(:comments) do
      add :comment, :string
      add :user_id, references(:users)
      add :topic_id, references(:topics)
      timestamps()
    end
  end
end
