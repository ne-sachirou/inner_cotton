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

  @type facts :: map
  @type results :: keyword(integer)
  @type tasks :: keyword(Task.t())

  @doc """
  Lint by Credo & check types by Dialyzer.
  """
  @impl true
  def run(args) do
    Mix.Task.run("cmd", ["mix do deps.get, compile"])

    {[], gather_facts(args)}
    |> check_async(:format, &check_format/1)
    |> check_async(:credo, &check_credo/1)
    |> check_async(
      :dialyzer,
      Task.async(Mix.Shell.IO, :cmd, ["mix dialyzer --halt-exit-status"])
    )
    |> check_async(:inch, &check_inch/1)
    |> await_checks
    |> print_check_results
  end

  defp check_format(facts) do
    if facts.fix?, do: Mix.Shell.IO.cmd("mix format --check-equivalent")
    Mix.Shell.IO.cmd("mix format --check-formatted")
  end

  defp check_credo(_) do
    alias Credo.Application
    alias Credo.Execution
    alias Credo.Execution.Task.WriteDebugReport
    alias Credo.MainProcess

    Application.start(nil, nil)

    %Execution{argv: ["--strict"]}
    |> MainProcess.call()
    |> WriteDebugReport.call([])
    |> Execution.get_assign("credo.exit_status", 0)
  end

  defp check_inch(%{docs?: false}), do: -1

  defp check_inch(_) do
    alias InchEx.CLI

    CLI.main(["--pedantic"])
    0
  end

  @spec gather_facts([binary]) :: facts
  defp gather_facts(args) do
    %{
      docs?: Mix.Tasks.Docs in Mix.Task.load_all(),
      fix?: "--fix" in args
    }
  end

  @spec check_async({tasks, facts}, atom, (facts -> integer) | Task.t()) :: {tasks, facts}
  defp check_async({tasks, facts}, name, %Task{} = task), do: {[{name, task} | tasks], facts}

  defp check_async({tasks, facts}, name, fun),
    do: check_async({tasks, facts}, name, Task.async(fn -> fun.(facts) end))

  @spec await_checks({tasks, facts}) :: results
  defp await_checks({tasks, _}),
    do: for({name, task} <- Enum.reverse(tasks), do: {name, Task.await(task, :infinity)})

  @spec print_check_results(results) :: any
  defp print_check_results(results) do
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
