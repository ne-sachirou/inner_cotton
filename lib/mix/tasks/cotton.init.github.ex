defmodule Mix.Tasks.Cotton.Init.Github do
  @moduledoc """
  Initialize or update GitHub config files.

  * .github/workflows/test.yml
  * README.md
  """

  alias InnerCotton.Updater.GitHubActions

  use Mix.Task

  @shortdoc "Initialize or update GitHub config files"

  @impl Mix.Task
  def run(_args), do: GitHubActions.update()
end
