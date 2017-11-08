defmodule Mix.Tasks.Cotton.Watch do
  @moduledoc """
  Experimental: EyeDrops
  """

  use Mix.Task

  @shortdoc "Experimental: EyeDrops"

  @doc """
  Experimental: EyeDrops
  """
  @spec run([binary]) :: any
  def run(_args) do
    tasks = Application.get_env :eye_drops, :tasks, []
    tasks = [
      %{
        id: :cotton_watch_lib,
        name: lib_cmd(),
        cmd: lib_cmd(),
        paths: ["lib"],
      },
      %{
        id: :cotton_watch_test,
        name: test_cmd(),
        cmd: test_cmd(),
        paths: ["test"],
      }
      | tasks
    ]
    Application.put_env :eye_drops, :tasks, tasks
    Mix.Task.run "eye_drops", ["--include-tasks", "cotton_watch_lib,cotton_watch_test"]
  end

  defp lib_cmd do
    cmds = [
      "mix test --color",
      "mix cotton.lint",
    ]
    cmds = if Mix.Tasks.Docs in Mix.Task.load_all, do: ["mix docs" | cmds], else: cmds
    Enum.join cmds, " && "
  end

  defp test_cmd, do: "mix test --color"
end
