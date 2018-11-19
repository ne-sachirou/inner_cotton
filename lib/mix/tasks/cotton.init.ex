defmodule Mix.Tasks.Cotton.Init do
  @moduledoc """
  Initialize or update config files.

  * .credo.exs
  * .formatter.exs
  * .gitignore
  * README.md
  * .travis.yml
  """

  alias InnerCotton.Updater.{Credo, Formatter, Gitignore, Readme, Travis}

  use Mix.Task

  @shortdoc "Initialize or update config files"

  @impl Mix.Task
  def run(_args), do: Enum.map([Credo, Formatter, Gitignore, Readme, Travis], & &1.update())
end
