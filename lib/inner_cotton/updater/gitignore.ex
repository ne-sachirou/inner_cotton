defmodule InnerCotton.Updater.Gitignore do
  @moduledoc """
  Init or update `.gitignore`.
  """

  alias InnerCotton.Updater

  @behaviour Updater

  @impl Updater
  def update do
    IO.puts("Initialize .gitignore")
    File.touch(".gitignore")
    config = File.read!(".gitignore")
    config = if String.match?(config, ~r{^/docs$}m), do: config, else: config <> "\n/docs\n"
    File.write!(".gitignore", config)
  end
end
