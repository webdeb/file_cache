defmodule FileCache do
  @moduledoc """
  Documentation for FileCache.
  """

  @doc """
  stores some data by id
  """
  def store(id, data) do
    File.mkdir(path())
    File.write(path_by_id(id), :erlang.term_to_binary(data))
  end

  @doc """
  loads some data by id
  """
  def load(id) do
    result = File.read(path_by_id(id))
    case result do
      {:ok, binary} -> :erlang.binary_to_term(binary)
      _ -> nil
    end
  end

  @doc """
  clears the complete cache_path
  """
  def clear() do
    File.rm_rf(path())
  end

  defp path_by_id(id) when is_atom(id) do
    Path.join(path(), Atom.to_string(id))
  end

  defp path() do
    Application.get_env(:file_cache, :path, Path.join(File.cwd!, "cache"))
  end
end
