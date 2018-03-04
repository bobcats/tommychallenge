defmodule Tommychallenge.Web.Accounts.UserControllerTest do
  use Tommychallenge.Web.ConnCase

  alias Tommychallenge.Accounts.User
  alias Tommychallenge.Repo

  @valid_attrs %{email: "jdilla@gmail.com", username: "jdilla", password: "s3cr3t"}
  @invalid_attrs %{email: nil, username: nil, password: nil}

  setup %{conn: conn} do
    {
      :ok,
      conn: put_req_header(
        conn,
        "accept",
        "application/json"
      )
    }
  end

  test "creates and renders resource when data is valid" do
    conn = post build_conn(), user_path(build_conn(), :create), user: @valid_attrs
    body = json_response(conn, 201)

    assert body["data"]["id"]
    assert body["data"]["email"]
    assert body["data"]["username"]
    refute body["data"]["password"] # Don't want to return password. Duh.
    assert Repo.get_by(User, email: "jdilla@gmail.com")
  end

  test "does not create resource and renders errors when data is invalid" do
    conn = post build_conn(), user_path(build_conn(), :create), user: @invalid_attrs
    assert json_response(conn, 422)["errors"] != %{}
  end
end