defmodule Tommychallenge.Web.SongView do
  use Tommychallenge.Web, :view
  alias Tommychallenge.Web.SongView

  def render("index.json", %{songs: songs}) do
    %{data: render_many(songs, SongView, "song.json")}
  end

  def render("show.json", %{song: song}) do
    %{data: render_one(song, SongView, "song.json")}
  end

  def render("song.json", %{song: song}) do
    %{id: song.id,
      phrase: song.phrase,
      title: song.title,
      artist: song.artist,
      live_at: song.live_at,
      link: song.link}
  end
end
