defmodule RandomWords.Word do
  alias RandomWords.Word

  @behaviour RandomWords
  @unix_dictionary "/usr/share/dict/words"
  @unix_dictionary_backup "/usr/dict/words"

  def generate do
    try do
      get_word_list |> Enum.random
    rescue
      _ in File.Error ->
        { :error, "An error occured reading from UNIX dictionary." }
    end
  end

  defp get_word_list do
    case File.read(@unix_dictionary) do
      { :ok, words } ->
        words |> String.split("\n")
      { :error, _}  ->
        case File.read(@unix_dictionary_backup) do
          { :ok, words } ->
            words |> String.split("\n")
          { :error, _ } ->
            raise File.Error
        end
    end
  end
end
