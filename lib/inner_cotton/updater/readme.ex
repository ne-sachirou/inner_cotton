defmodule InnerCotton.Updater.Readme do
  @moduledoc """
  Init or update `README.md`.
  """

  alias InnerCotton.Updater

  @behaviour Updater

  @readme_path "README.md"

  @impl Updater
  def update do
    IO.puts("Initialize README.md")
    File.touch(@readme_path)

    readme =
      @readme_path
      |> File.read!()
      |> add_github_actions
      |> add_hexpm
      |> add_coveralls

    File.write!(@readme_path, readme)
  end

  defp add_github_actions(readme) do
    line =
      "[![Actions Status](https://github.com/AUTHER_NAME/PROJECT_NAME/workflows/test/badge.svg)](https://github.com/AUTHER_NAME/PROJECT_NAME/actions)"

    flake = "[![Actions Status](https://github.com/"
    add_line(readme, line, flake)
  end

  defp add_hexpm(readme) do
    line =
      "[![Hex.pm](https://img.shields.io/hexpm/v/PROJECT_NAME.svg)](https://hex.pm/packages/PROJECT_NAME)"

    flake = "[![Hex.pm](https://img.shields.io/hexpm/v/"
    add_line(readme, line, flake)
  end

  defp add_coveralls(readme) do
    line =
      "[![Coverage Status](https://coveralls.io/repos/github/AUTHOR_NAME/PROJECT_NAME/badge.svg)](https://coveralls.io/github/AUTHOR_NAME/PROJECT_NAME)"

    flake = "[![Coverage Status](https://coveralls.io/repos/"
    add_line(readme, line, flake)
  end

  defp add_line(readme, line, flake) do
    if readme |> String.split("\n") |> Enum.any?(&String.starts_with?(&1, flake)),
      do: readme,
      else: line <> "\n" <> readme
  end
end
