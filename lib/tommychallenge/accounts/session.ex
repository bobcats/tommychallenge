defmodule Tommychallenge.Accounts.Session do
  use Ecto.Schema
  import Ecto.Changeset

  alias Tommychallenge.Repo
  alias Tommychallenge.Accounts.Session

  schema "sessions" do
    field :token, :string
    belongs_to :user, Tommychallenge.Accounts.User

    timestamps()
  end

  @required_attrs [:user_id]

  def changeset(session, attrs \\ {}) do
    session
    |> cast(attrs, @required_attrs)
    |> validate_required(@required_attrs)
  end

  def create_changeset(session, attrs \\ {}) do
    session
    |> changeset(attrs)
    |> put_change(:token, SecureRandom.urlsafe_base64())
  end
end