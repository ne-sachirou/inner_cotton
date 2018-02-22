defmodule Mix.Tasks.Cotton.Lint do
  @moduledoc """
  Run following checks.

  ```
  mix format --check-formatted
  mix credo --strict
  mix dialyzer
  mix inch --pedantic
  ```

  Option:

  --fix : Auto correct errors if available.
  """

  use Mix.Task

  @shortdoc "Lint by Credo & check types by Dialyzer"

  @doc """
  Lint by Credo & check types by Dialyzer.
  """
  @spec run([binary]) :: any
  def run(args) do
    fix? = "--fix" in args
    Mix.Task.run("compile")

    [format, credo, dialyzer, inch] =
      Enum.map(
        [
          Task.async(fn ->
            if fix?, do: Mix.Shell.IO.cmd("mix format --check-equivalent")
            Mix.Shell.IO.cmd("mix format --check-formatted")
          end),
          Task.async(fn -> Mix.Shell.IO.cmd("mix credo --strict") end),
          Task.async(fn -> Mix.Shell.IO.cmd("mix dialyzer --halt-exit-status") end),
          Task.async(fn ->
            if Mix.Tasks.Docs in Mix.Task.load_all(),
              do: Mix.Shell.IO.cmd("mix inch --pedantic"),
              else: 0
          end)
        ],
        &Task.await(&1, :infinity)
      )

    for {name, status} <- [format: format, credo: credo, dialyzer: dialyzer, inch: inch] do
      IO.puts(
        String.pad_trailing(to_string(name), 9) <> ":\t" <> if(0 === status, do: "ok", else: "ng")
      )
    end

    :erlang.halt(format + credo + dialyzer + inch)
  end
end
