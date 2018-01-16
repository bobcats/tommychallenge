defmodule Tommychallenge.Repo.Migrations.CreateUser do
  use Ecto.Migration

  def change do
    create table(:users) do
      add :username, :text, null: false
      add :name, :text
      add :email, :text, null: false
      add :password_hash, :text

      timestamps()
    end

    create unique_index(:users, [:email])
  end
end
