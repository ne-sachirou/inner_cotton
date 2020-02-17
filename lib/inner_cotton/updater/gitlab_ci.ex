defmodule InnerCotton.Updater.GitLabCI do
  @moduledoc """
  Init or update `.gitlab-ci.yml`.
  """

  alias InnerCotton.Updater
  alias InnerCotton.Updater.Readme

  @behaviour Updater

  @impl Updater
  def update do
    IO.puts("Initialize .gitlab-ci.yml")

    File.cp!(
      Path.join(:code.priv_dir(:inner_cotton), ".gitlab-ci.yml"),
      Path.join(File.cwd!(), ".gitlab-ci.yml")
    )

    add_badge()
  end

  defp add_badge do
    Readme.add_line(
      "[![Pipelines](https://gitlab.com/AUTHER_NAME/PROJECT_NAME/badges/master/pipeline.svg)](https://gitlab.com/AUTHER_NAME/PROJECT_NAME/pipelines)",
      "[![Pipelines](https://gitlab.com/"
    )

    Readme.add_line(
      "[![Coverage Status](https://coveralls.io/repos/github/AUTHOR_NAME/PROJECT_NAME/badge.svg)](https://coveralls.io/github/AUTHOR_NAME/PROJECT_NAME)",
      "[![Coverage Status](https://coveralls.io/repos/"
    )
  end
end
