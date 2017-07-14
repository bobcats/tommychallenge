defmodule Tommychallenge.Challenges.Submission do
  use Ecto.Schema
  import Ecto.Changeset
  alias Tommychallenge.Challenges.Submission


  schema "challenges_submissions" do
    field :artist, :string
    field :downvotes, :integer
    field :link, :string
    field :title, :string
    field :upvotes, :integer
    field :song_id, :id

    timestamps()
  end

  @doc false
  def changeset(%Submission{} = submission, attrs) do
    submission
    |> cast(attrs, [:title, :artist, :link, :upvotes, :downvotes])
    |> validate_required([:title, :artist, :link, :upvotes, :downvotes])
  end
end
