defmodule RandomWords.HTTP do
  @behaviour RandomWords
  @url "http://setgetgo.com/randomword/get.php"

  def get do
    HTTPoison.get!(@url).body
  end
end
