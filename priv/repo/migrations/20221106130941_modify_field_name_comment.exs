defmodule Talk.Repo.Migrations.ModifyFieldNameComment do
  use Ecto.Migration

  def change do
    rename table("comments"), :comment, to: :content
  end
end
