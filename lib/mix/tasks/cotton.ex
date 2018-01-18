defmodule Mix.Tasks.Cotton do
  @moduledoc """
  Collection of recommended Elixir check utilities.

  * `mix cotton.init` : Initialize or update config files
  * `mix cotton.lint` : Lint by Credo & check types by Dialyzer
  * `mix cotton.watch` : Watch file changes then run lint & test
  """

  use Mix.Task

  @shortdoc "Collection of recommended Elixir check utilities."

  @doc """
  Collection of recommended Elixir check utilities.
  """
  @spec run([binary]) :: any
  def run(_args), do: Mix.Task.run("help", ["cotton"])
end
