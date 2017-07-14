defmodule Tommychallenge.Web.SongController do
  use Tommychallenge.Web, :controller

  alias Tommychallenge.Challenges
  alias Tommychallenge.Challenges.Song

  action_fallback Tommychallenge.Web.FallbackController

  def index(conn, _params) do
    songs = Challenges.list_songs()
    render(conn, "index.json", songs: songs)
  end

  def create(conn, %{"song" => song_params}) do
    with {:ok, %Song{} = song} <- Challenges.create_song(song_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", song_path(conn, :show, song))
      |> render("show.json", song: song)
    end
  end

  def show(conn, %{"id" => id}) do
    song = Challenges.get_song!(id)
    render(conn, "show.json", song: song)
  end

  def update(conn, %{"id" => id, "song" => song_params}) do
    song = Challenges.get_song!(id)

    with {:ok, %Song{} = song} <- Challenges.update_song(song, song_params) do
      render(conn, "show.json", song: song)
    end
  end

  def delete(conn, %{"id" => id}) do
    song = Challenges.get_song!(id)
    with {:ok, %Song{}} <- Challenges.delete_song(song) do
      send_resp(conn, :no_content, "")
    end
  end
end
