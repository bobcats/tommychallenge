defmodule Tommychallenge.Repo.Migrations.CreateTommychallenge.Challenges.Submission do
  use Ecto.Migration

  def change do
    create table(:challenges_submissions) do
      add :title, :text
      add :artist, :text
      add :link, :text
      add :upvotes, :integer
      add :downvotes, :integer
      add :song_id, references(:challenges_songs, on_delete: :nothing)

      timestamps()
    end

    create index(:challenges_submissions, [:song_id])
  end
end
