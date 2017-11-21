defmodule Tommychallenge.Web.SongControllerTest do
  use Tommychallenge.Web.ConnCase

  alias Tommychallenge.Challenges

  @create_attrs %{
    artist: "some artist",
    link: "some link",
    live_at: %DateTime{
      calendar: Calendar.ISO,
      day: 17,
      hour: 14,
      microsecond: {0, 6},
      minute: 0,
      month: 4,
      second: 0,
      std_offset: 0,
      time_zone: "Etc/UTC",
      utc_offset: 0,
      year: 2010,
      zone_abbr: "UTC",
    },
    phrase: "some phrase",
    title: "some title",
  }

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

  test "list individual entry on show", %{conn: conn} do
    id = fixture(:song).id
    conn = get conn, song_path(conn, :show, id)
    assert json_response(conn, 200)["data"] == %{
      "id" => id,
      "artist" => "some artist",
      "link" => "some link",
      "live_at" => "2010-04-17T14:00:00.000000Z",
      "phrase" => "some phrase",
      "title" => "some title",
    }
  end
end
