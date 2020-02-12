defmodule Mix.Tasks.Cotton.Init do
  @moduledoc """
  Initialize or update config files.

  * .credo.exs
  * .formatter.exs
  * .github/workflows/test.yml
  * .gitignore
  * .gitlab-ci.yml
  * README.md
  """

  alias InnerCotton.Updater.{Credo, Formatter, GitHubActions, Gitignore, GitLabCI, Readme}

  use Mix.Task

  @shortdoc "Initialize or update config files"

  @impl Mix.Task
  def run(_args),
    do: Enum.map([Credo, Formatter, GitHubActions, Gitignore, GitLabCI, Readme], & &1.update())
end
