defmodule Mix.Tasks.Cotton.Init do
  @moduledoc """
  Initialize or update config files.

  * .credo.exs
  * .formatter.exs
  * .gitignore
  * README.md
  """

  alias InnerCotton.Updater.{Credo, Formatter, Gitignore, Readme}

  use Mix.Task

  @shortdoc "Initialize or update config files"

  @impl Mix.Task
  def run(_args), do: Enum.map([Credo, Formatter, Gitignore, Readme], & &1.update())
end
