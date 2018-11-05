defmodule InnerCotton.Updater.Credo do
  @moduledoc """
  Init or update `.credo.exs`.
  """

  alias InnerCotton.Updater

  @behaviour Updater

  @impl Updater
  def update do
    IO.puts("Initialize .credo.exs")

    case File.rm(".credo.exs") do
      :ok -> nil
      {:error, :enoent} -> nil
      {:error, reason} -> raise "`rm .credo.exs` : #{reason}"
    end

    Mix.Task.run("credo.gen.config")
  end
end
