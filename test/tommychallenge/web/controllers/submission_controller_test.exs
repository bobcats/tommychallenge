defmodule Tommychallenge.Web.SubmissionControllerTest do
  use Tommychallenge.Web.ConnCase

  alias Tommychallenge.Challenges
  alias Tommychallenge.Challenges.Submission

  @create_attrs %{artist: "some artist", downvotes: 42, link: "some link", title: "some title", upvotes: 42}
  @update_attrs %{artist: "some updated artist", downvotes: 43, link: "some updated link", title: "some updated title", upvotes: 43}
  @invalid_attrs %{artist: nil, downvotes: nil, link: nil, title: nil, upvotes: nil}

  def fixture(:submission) do
    {:ok, submission} = Challenges.create_submission(@create_attrs)
    submission
  end

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  test "lists all entries on index", %{conn: conn} do
    conn = get conn, submission_path(conn, :index)
    assert json_response(conn, 200)["data"] == []
  end

  test "creates submission and renders submission when data is valid", %{conn: conn} do
    conn = post conn, submission_path(conn, :create), submission: @create_attrs
    assert %{"id" => id} = json_response(conn, 201)["data"]

    conn = get conn, submission_path(conn, :show, id)
    assert json_response(conn, 200)["data"] == %{
      "id" => id,
      "artist" => "some artist",
      "downvotes" => 42,
      "link" => "some link",
      "title" => "some title",
      "upvotes" => 42}
  end

  test "does not create submission and renders errors when data is invalid", %{conn: conn} do
    conn = post conn, submission_path(conn, :create), submission: @invalid_attrs
    assert json_response(conn, 422)["errors"] != %{}
  end

  test "updates chosen submission and renders submission when data is valid", %{conn: conn} do
    %Submission{id: id} = submission = fixture(:submission)
    conn = put conn, submission_path(conn, :update, submission), submission: @update_attrs
    assert %{"id" => ^id} = json_response(conn, 200)["data"]

    conn = get conn, submission_path(conn, :show, id)
    assert json_response(conn, 200)["data"] == %{
      "id" => id,
      "artist" => "some updated artist",
      "downvotes" => 43,
      "link" => "some updated link",
      "title" => "some updated title",
      "upvotes" => 43}
  end

  test "does not update chosen submission and renders errors when data is invalid", %{conn: conn} do
    submission = fixture(:submission)
    conn = put conn, submission_path(conn, :update, submission), submission: @invalid_attrs
    assert json_response(conn, 422)["errors"] != %{}
  end

  test "deletes chosen submission", %{conn: conn} do
    submission = fixture(:submission)
    conn = delete conn, submission_path(conn, :delete, submission)
    assert response(conn, 204)
    assert_error_sent 404, fn ->
      get conn, submission_path(conn, :show, submission)
    end
  end
end
