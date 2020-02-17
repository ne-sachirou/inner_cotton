defmodule InnerCotton.Updater.Readme do
  @moduledoc """
  Init or update `README.md`.
  """

  alias InnerCotton.Updater

  @behaviour Updater

  @readme_path "README.md"

  def update do
    IO.puts("Initialize README.md")
    File.touch(@readme_path)
    add_hexpm()
  end

  defp add_hexpm do
    add_line(
      "[![Hex.pm](https://img.shields.io/hexpm/v/PROJECT_NAME.svg)](https://hex.pm/packages/PROJECT_NAME)",
      "[![Hex.pm](https://img.shields.io/hexpm/v/"
    )
  end

  def add_line(line, flake) do
    readme = File.read!(@readme_path)

    readme =
      if readme |> String.split("\n") |> Enum.any?(&String.starts_with?(&1, flake)),
        do: readme,
        else: line <> "\n" <> readme

    File.write!(@readme_path, readme)
  end
end
