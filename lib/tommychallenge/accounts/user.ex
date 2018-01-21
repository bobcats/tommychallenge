defmodule Tommychallenge.Accounts.User do
  use Ecto.Schema
  import Ecto.Changeset

  alias Tommychallenge.Repo
  alias Tommychallenge.Accounts.User

  schema "users" do
    field :name, :string
    field :username, :string
    field :email, :string
    field :password_hash, :string
    field :password, :string, virtual: true

    timestamps()
  end

  @required_attrs [:email, :username]
  def create_user(attrs \\ %{}) do
    %User{}
    |> User.registration_changeset(attrs)
    |> Repo.insert()
  end

  def changeset(%User{} = user, attrs \\ %{}) do
    user
    |> cast(attrs, [:email, :name, :username])
    |> validate_required(@required_attrs)
    |> validate_length(:username, min: 3, max: 20)
    |> validate_format(:email, ~r/@/)
  end

  def registration_changeset(%User{} = user, attrs \\ %{}) do
    user
    |> changeset(attrs)
    |> cast(attrs, [:password])
    |> validate_required([:password])
    |> validate_length(:password, min: 6)
    |> put_password_hash
  end

  defp put_password_hash(changeset) do
    case changeset do
      %Ecto.Changeset{valid?: true, changes: %{password: pass}} ->
        put_change(changeset, :password_hash, Comeonin.Pbkdf2.hashpwsalt(pass))
      _ ->
        changeset
    end
  end
end
