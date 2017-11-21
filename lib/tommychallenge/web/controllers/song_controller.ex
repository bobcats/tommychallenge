defmodule Tommychallenge.Web.SongController do
  use Tommychallenge.Web, :controller

  alias Tommychallenge.Challenges
  alias Tommychallenge.Challenges.Song

  action_fallback Tommychallenge.Web.FallbackController

  def index(conn, _params) do
    songs = Challenges.list_songs()
    render(conn, "index.json", songs: songs)
  end

  def show(conn, %{"id" => id}) do
    song = Challenges.get_song!(id)
    render(conn, "show.json", song: song)
  end
end
