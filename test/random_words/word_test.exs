defmodule RandomWords.WordTest do
  alias RandomWords.Word
  use Tommychallenge.DataCase

  test "#generate returns a random word when UNIX dictionary exists" do
    random_word = Word.generate
    assert is_binary(random_word)
  end
end