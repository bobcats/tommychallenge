defmodule Tommychallenge.Repo.Migrations.CreateTommychallenge.Challenges.Song do
  use Ecto.Migration

  def change do
    create table(:challenges_songs) do
      add :phrase, :text
      add :title, :text
      add :artist, :text
      add :live_at, :utc_datetime
      add :link, :text

      timestamps()
    end

  end
end
