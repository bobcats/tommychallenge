defmodule RandomWords do
  @doc """
  Returns a random word as a String
  """
  @callback get :: String.t
end
