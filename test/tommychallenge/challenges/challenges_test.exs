defmodule Tommychallenge.ChallengesTest do
  use Tommychallenge.DataCase

  alias Tommychallenge.Challenges

  describe "songs" do
    alias Tommychallenge.Challenges.Song

    @valid_attrs %{artist: "some artist", link: "some link", live_at: %DateTime{calendar: Calendar.ISO, day: 17, hour: 14, microsecond: {0, 6}, minute: 0, month: 4, second: 0, std_offset: 0, time_zone: "Etc/UTC", utc_offset: 0, year: 2010, zone_abbr: "UTC"}, phrase: "some phrase", title: "some title"}
    @update_attrs %{artist: "some updated artist", link: "some updated link", live_at: %DateTime{calendar: Calendar.ISO, day: 18, hour: 15, microsecond: {0, 6}, minute: 1, month: 5, second: 1, std_offset: 0, time_zone: "Etc/UTC", utc_offset: 0, year: 2011, zone_abbr: "UTC"}, phrase: "some updated phrase", title: "some updated title"}
    @invalid_attrs %{artist: nil, link: nil, live_at: nil, phrase: nil, title: nil}

    def song_fixture(attrs \\ %{}) do
      {:ok, song} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Challenges.create_song()

      song
    end

    test "list_songs/0 returns all songs" do
      song = song_fixture()
      assert Challenges.list_songs() == [song]
    end

    test "get_song!/1 returns the song with given id" do
      song = song_fixture()
      assert Challenges.get_song!(song.id) == song
    end

    test "create_song/1 with valid data creates a song" do
      assert {:ok, %Song{} = song} = Challenges.create_song(@valid_attrs)
      assert song.artist == "some artist"
      assert song.link == "some link"
      assert song.live_at == %DateTime{calendar: Calendar.ISO, day: 17, hour: 14, microsecond: {0, 6}, minute: 0, month: 4, second: 0, std_offset: 0, time_zone: "Etc/UTC", utc_offset: 0, year: 2010, zone_abbr: "UTC"}
      assert song.phrase == "some phrase"
      assert song.title == "some title"
    end

    test "create_song/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Challenges.create_song(@invalid_attrs)
    end

    test "update_song/2 with valid data updates the song" do
      song = song_fixture()
      assert {:ok, song} = Challenges.update_song(song, @update_attrs)
      assert %Song{} = song
      assert song.artist == "some updated artist"
      assert song.link == "some updated link"
      assert song.live_at == %DateTime{calendar: Calendar.ISO, day: 18, hour: 15, microsecond: {0, 6}, minute: 1, month: 5, second: 1, std_offset: 0, time_zone: "Etc/UTC", utc_offset: 0, year: 2011, zone_abbr: "UTC"}
      assert song.phrase == "some updated phrase"
      assert song.title == "some updated title"
    end

    test "update_song/2 with invalid data returns error changeset" do
      song = song_fixture()
      assert {:error, %Ecto.Changeset{}} = Challenges.update_song(song, @invalid_attrs)
      assert song == Challenges.get_song!(song.id)
    end

    test "delete_song/1 deletes the song" do
      song = song_fixture()
      assert {:ok, %Song{}} = Challenges.delete_song(song)
      assert_raise Ecto.NoResultsError, fn -> Challenges.get_song!(song.id) end
    end

    test "change_song/1 returns a song changeset" do
      song = song_fixture()
      assert %Ecto.Changeset{} = Challenges.change_song(song)
    end
  end
end
