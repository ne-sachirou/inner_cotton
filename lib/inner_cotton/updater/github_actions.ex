defmodule InnerCotton.Updater.GitHubActions do
  @moduledoc """
  Init or update `.github/workflows/test.yml`.
  """

  alias InnerCotton.Updater
  alias InnerCotton.Updater.Readme

  @behaviour Updater

  @impl Updater
  def update do
    IO.puts("Initialize .github/workflows/test.yml")
    File.mkdir_p!(Path.join(File.cwd!(), ".github/workflows"))

    File.cp!(
      Path.join(:code.priv_dir(:inner_cotton), ".github-workflows-test.yml"),
      Path.join(File.cwd!(), ".github/workflows/test.yml")
    )

    add_badge()
  end

  defp add_badge do
    Readme.add_line(
      "[![Actions Status](https://github.com/AUTHER_NAME/PROJECT_NAME/workflows/test/badge.svg)](https://github.com/AUTHER_NAME/PROJECT_NAME/actions)",
      "[![Actions Status](https://github.com/"
    )

    Readme.add_line(
      "[![Coverage Status](https://coveralls.io/repos/github/AUTHOR_NAME/PROJECT_NAME/badge.svg)](https://coveralls.io/github/AUTHOR_NAME/PROJECT_NAME)",
      "[![Coverage Status](https://coveralls.io/repos/"
    )
  end
end
