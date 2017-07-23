defmodule Mix.Tasks.Cotton.Lint do
  @moduledoc """
  Run following checks.

  ```
  mix credo --strict
  mix dialyzer
  mix inch
  ```
  """

  use Mix.Task

  @shortdoc "Lint by Credo & check types by Dialyzer"

  @doc """
  Callback
  """
  @spec run([binary]) :: any
  def run(_args) do
    Mix.Task.run "credo", ["--strict"]
    Mix.Task.run "dialyzer"
    Mix.Task.run "inch", ["--pedantic"]
  end
end
