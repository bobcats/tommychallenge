defmodule Spotify.HTTP do
  @token_url "https://accounts.spotify.com/api/token"
  @search_url "https://api.spotify.com/v1/search"

  alias Spotify.Track

  def search_for_track(phrase) do
    body = HTTPoison.get!(
      "#{@search_url}?#{search_query(phrase)}",
      search_headers()
    ).body

    %{
      "tracks" => %{
        "items" => [%{
          "uri" => uri,
          "artists" => [%{"name" => artist} | _rest],
          "name" => name,
        }]
      }
    } = Poison.decode!(body)

    %Track{
      artist: artist,
      name: name,
      uri: uri,
    }
  end

  def search_query(phrase) do
    URI.encode_query(%{
      "type" => "track",
      "q" => phrase,
      "limit" => 1,
    })
  end

  def search_headers do
    {:ok, token} = token()

    [
      {"Authorization", "Bearer #{token}"},
      {"Content-Type", "application/json"},
    ]
  end

  def token do
    case get_token() do
      {:ok, %HTTPoison.Response{status_code: 200, body: body}} ->
        case Poison.decode(body) do
          {:ok, %{"access_token" => access_token}} ->
            {:ok, access_token}
          _ ->
            raise body
        end
      {:error, %HTTPoison.Error{reason: reason}} ->
        {:error, reason}
    end
  end

  def get_token do
    HTTPoison.post(@token_url, "grant_type=client_credentials", token_headers())
  end

  def token_headers do
    [
      {"Authorization", "Basic #{encoded_credentials()}"},
      {"Content-Type", "application/x-www-form-urlencoded"}
    ]
  end

  def encoded_credentials do
    :base64.encode("#{client_id()}:#{client_secret()}")
  end

  def client_id do
    Application.get_env(:tommychallenge, :spotify_client_id)
  end

  def client_secret do
    Application.get_env(:tommychallenge, :spotify_client_secret)
  end
end
