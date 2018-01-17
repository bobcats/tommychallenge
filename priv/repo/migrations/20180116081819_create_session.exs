defmodule Tommychallenge.Repo.Migrations.CreateSession do
  use Ecto.Migration

  def change do
    create table(:sessions) do
      add :user_id, references(:users, on_delete: :nothing)
      add :token, :text, null: false

      timestamps()
    end

    create index(:sessions, [:user_id])
    create index(:sessions, [:token])
  end
end
