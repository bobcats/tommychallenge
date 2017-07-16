defmodule Spotify.Mock do
  alias Spotify.Track

  def search_for_track(_phrase) do
    %Track{
      artist: "Young Thug",
      name: "Wyclef Jean",
      uri: "spotify:track:55OdqrG8WLmsYyY1jijD9b",
    }
  end
end
