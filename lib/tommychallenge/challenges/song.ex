defmodule Tommychallenge.Challenges.Song do
  use Ecto.Schema
  import Ecto.Changeset
  alias Tommychallenge.Challenges.Song


  schema "challenges_songs" do
    field :artist, :string
    field :link, :string
    field :live_at, :utc_datetime
    field :phrase, :string
    field :title, :string

    timestamps()
  end

  @doc false
  def changeset(%Song{} = song, attrs) do
    song
    |> cast(attrs, [:phrase, :title, :artist, :live_at, :link])
    |> validate_required([:phrase, :title, :artist, :live_at, :link])
  end
end
