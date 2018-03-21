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
    Mix.Task.run("cmd", ["mix do deps.get, compile"])

    results =
      for {name, task} <-
            [
              format:
                Task.async(fn ->
                  if fix?, do: Mix.Shell.IO.cmd("mix format --check-equivalent")
                  Mix.Shell.IO.cmd("mix format --check-formatted")
                end),
              credo: Task.async(Mix.Shell.IO, :cmd, ["mix credo --strict"]),
              dialyzer: Task.async(Mix.Shell.IO, :cmd, ["mix dialyzer --halt-exit-status"]),
              inch:
                Task.async(fn ->
                  if Mix.Tasks.Docs in Mix.Task.load_all(),
                    do: Mix.Shell.IO.cmd("mix inch --pedantic"),
                    else: -1
                end)
            ] do
        {name, Task.await(task, :infinity)}
      end

    label_length =
      results |> Keyword.keys() |> Enum.map(&(&1 |> to_string |> String.length())) |> Enum.max()

    for {name, status} <- results, status >= 0 do
      IO.puts(
        String.pad_trailing(to_string(name), label_length + 1) <>
          ":\t" <> if(0 === status, do: "ok", else: "ng")
      )
    end

    case results |> Keyword.values() |> Enum.map(&max(&1, 0)) |> Enum.sum() do
      0 -> nil
      exit_status -> :erlang.halt(exit_status)
    end
  end
end
