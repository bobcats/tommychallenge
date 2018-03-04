defmodule Tommychallenge.SessionTest do
  use Tommychallenge.DataCase

  alias Tommychallenge.Accounts.Session

  @valid_attrs %{user_id: "1"}
  @invalid_attrs %{}

  test "changeset is valid with valid attributes" do
    changeset = Session.changeset(%Session{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset is invalid with invalid attributes" do
    changeset = Session.changeset(%Session{}, @invalid_attrs)
    refute changeset.valid?
  end

  test "create_changeset is valid with valid attributes" do
    changeset = Session.create_changeset(%Session{}, @valid_attrs)
    assert changeset.changes.token
    assert changeset.valid?
  end

  test "create_changeset is invalid with invalid attributes" do
    changeset = Session.create_changeset(%Session{}, @invalid_attrs)
    refute changeset.valid?
  end
end