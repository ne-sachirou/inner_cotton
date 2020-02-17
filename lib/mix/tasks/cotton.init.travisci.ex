defmodule Mix.Tasks.Cotton.Init.Travisci do
  @moduledoc """
  Initialize or update TravisCI config files.

  * .travis.yml
  * README.md
  """

  alias InnerCotton.Updater.TravisCI

  use Mix.Task

  @shortdoc "Initialize or update TravisCI config files"

  @impl Mix.Task
  def run(_args), do: TravisCI.update()
end
