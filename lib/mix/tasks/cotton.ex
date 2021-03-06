defmodule Mix.Tasks.Cotton do
  @moduledoc """
  Collection of recommended Elixir check utilities.

  * `mix cotton.init` : Initialize or update config files
  * `mix cotton.lint` : Lint by Credo & check types by Dialyzer
  """

  use Mix.Task

  @shortdoc "Collection of recommended Elixir check utilities."

  @impl true
  def run(_args), do: Mix.Task.run("help", ["cotton"])
end
