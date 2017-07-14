defmodule Tommychallenge.Web.SongControllerTest do
  use Tommychallenge.Web.ConnCase

  alias Tommychallenge.Challenges
  alias Tommychallenge.Challenges.Song

  @create_attrs %{artist: "some artist", link: "some link", live_at: %DateTime{calendar: Calendar.ISO, day: 17, hour: 14, microsecond: {0, 6}, minute: 0, month: 4, second: 0, std_offset: 0, time_zone: "Etc/UTC", utc_offset: 0, year: 2010, zone_abbr: "UTC"}, phrase: "some phrase", title: "some title"}
  @update_attrs %{artist: "some updated artist", link: "some updated link", live_at: %DateTime{calendar: Calendar.ISO, day: 18, hour: 15, microsecond: {0, 6}, minute: 1, month: 5, second: 1, std_offset: 0, time_zone: "Etc/UTC", utc_offset: 0, year: 2011, zone_abbr: "UTC"}, phrase: "some updated phrase", title: "some updated title"}
  @invalid_attrs %{artist: nil, link: nil, live_at: nil, phrase: nil, title: nil}

  def fixture(:song) do
    {:ok, song} = Challenges.create_song(@create_attrs)
    song
  end

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  test "lists all entries on index", %{conn: conn} do
    conn = get conn, song_path(conn, :index)
    assert json_response(conn, 200)["data"] == []
  end

  test "creates song and renders song when data is valid", %{conn: conn} do
    conn = post conn, song_path(conn, :create), song: @create_attrs
    assert %{"id" => id} = json_response(conn, 201)["data"]

    conn = get conn, song_path(conn, :show, id)
    assert json_response(conn, 200)["data"] == %{
      "id" => id,
      "artist" => "some artist",
      "link" => "some link",
      "live_at" => "2010-04-17T14:00:00.000000Z",
      "phrase" => "some phrase",
      "title" => "some title"}
  end

  test "does not create song and renders errors when data is invalid", %{conn: conn} do
    conn = post conn, song_path(conn, :create), song: @invalid_attrs
    assert json_response(conn, 422)["errors"] != %{}
  end

  test "updates chosen song and renders song when data is valid", %{conn: conn} do
    %Song{id: id} = song = fixture(:song)
    conn = put conn, song_path(conn, :update, song), song: @update_attrs
    assert %{"id" => ^id} = json_response(conn, 200)["data"]

    conn = get conn, song_path(conn, :show, id)
    assert json_response(conn, 200)["data"] == %{
      "id" => id,
      "artist" => "some updated artist",
      "link" => "some updated link",
      "live_at" => "2011-05-18T15:01:01.000000Z",
      "phrase" => "some updated phrase",
      "title" => "some updated title"}
  end

  test "does not update chosen song and renders errors when data is invalid", %{conn: conn} do
    song = fixture(:song)
    conn = put conn, song_path(conn, :update, song), song: @invalid_attrs
    assert json_response(conn, 422)["errors"] != %{}
  end

  test "deletes chosen song", %{conn: conn} do
    song = fixture(:song)
    conn = delete conn, song_path(conn, :delete, song)
    assert response(conn, 204)
    assert_error_sent 404, fn ->
      get conn, song_path(conn, :show, song)
    end
  end
end
