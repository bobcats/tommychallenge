defmodule Tommychallenge.Accounts.UserTest do
  use Tommychallenge.DataCase

  alias Tommychallenge.Accounts.User

  @valid_attrs %{
    name: "J Dilla",
    username: "jdilla",
    email: "jdilla@gmail.com",
    password: "s3cr3t"
  }

  test "changeset is valid with valid attributes" do
    changeset = User.changeset(%User{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset is invalid when email is an invalid format" do
    changeset = User.changeset(
      %User{}, Map.put(@valid_attrs, :email, "jd.com")
    )
    refute changeset.valid?
  end

  test "changeset is invalid when username is too short" do
    changeset = User.changeset(
      %User{}, Map.put(@valid_attrs, :username, "jd")
    )
    refute changeset.valid?
  end

  test "changeset is invalid when username is too long" do
    changeset = User.changeset(
      %User{}, Map.put(@valid_attrs, :username, "this is a long username")
    )
    refute changeset.valid?
  end

  test "registration_changeset is valid with valid password" do
    changeset = User.registration_changeset(
      %User{}, @valid_attrs
    )
    assert changeset.changes.password_hash
    assert changeset.valid?
  end

  test "registration_changeset is invalid when password is too short" do
    changeset = User.registration_changeset(
      %User{}, Map.put(@valid_attrs, :password, "badyo")
    )
    refute changeset.valid?
  end

  test "registration_changeset is invalid when email is taken" do
    user = User.registration_changeset(%User{}, @valid_attrs)
    assert {:ok, user } = Repo.insert(user)

    copycat = User.registration_changeset(%User{}, %{
      name: "J Dilla Imposter",
      username: "jdillaimp",
      email: "jdilla@gmail.com",
      password: "s3cr3t"
    })

    assert {:error, changeset} = Repo.insert(copycat)
    assert changeset.errors[:email] == {"has already been taken", []}
  end

  test "registration_changeset is invalid when username is taken" do
    user = User.registration_changeset(%User{}, @valid_attrs)
    assert {:ok, user } = Repo.insert(user)

    copycat = User.registration_changeset(%User{}, %{
      name: "J Dilla Imposter",
      username: "jdilla",
      email: "jdillaimp@gmail.com",
      password: "s3cr3t"
    })

    assert {:error, changeset} = Repo.insert(copycat)
    assert changeset.errors[:username] == {"has already been taken", []}
  end
end
