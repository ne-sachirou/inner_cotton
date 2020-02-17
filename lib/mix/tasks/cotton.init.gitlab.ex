defmodule Mix.Tasks.Cotton.Init.Gitlab do
  @moduledoc """
  Initialize or update GitLab config files.

  * .gitlab-ci.yml
  * README.md
  """

  alias InnerCotton.Updater.GitLabCI

  use Mix.Task

  @shortdoc "Initialize or update GitLab config files"

  @impl Mix.Task
  def run(_args), do: GitLabCI.update()
end
