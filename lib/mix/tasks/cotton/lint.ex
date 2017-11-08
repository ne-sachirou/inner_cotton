defmodule Mix.Tasks.Cotton.Lint do
  @moduledoc """
  Run following checks.

  ```
  mix credo --strict
  mix dialyzer
  mix inch --pedantic
  ```
  """

  use Mix.Task

  @shortdoc "Lint by Credo & check types by Dialyzer"

  @doc """
  Lint by Credo & check types by Dialyzer.
  """
  @spec run([binary]) :: any
  def run(_args) do
    Mix.Task.run "credo", ["--strict"]
    Mix.Task.run "dialyzer"
    if Mix.Tasks.Docs in Mix.Task.load_all,
      do: Mix.Task.run "inch", ["--pedantic"]
  end
end
