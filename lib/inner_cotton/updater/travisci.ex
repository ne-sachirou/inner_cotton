defmodule InnerCotton.Updater.TravisCI do
  @moduledoc """
  Init or update `.travis.yml`.
  """

  alias InnerCotton.Updater
  alias InnerCotton.Updater.Readme

  @behaviour Updater

  @impl Updater
  def update do
    IO.puts("Initialize .travis.yml")

    File.cp!(
      Path.join(:code.priv_dir(:inner_cotton), ".travis.yml"),
      Path.join(File.cwd!(), ".travis.yml")
    )

    add_badge()
  end

  defp add_badge do
    Readme.add_line(
      "[![Build Status](https://travis-ci.com/AUTHOR_NAME/PROJECT_NAME.svg?branch=master)](https://travis-ci.com/AUTHOR_NAME/PROJECT_NAME)",
      "[![Build Status](https://travis-ci.com/"
    )

    Readme.add_line(
      "[![Coverage Status](https://coveralls.io/repos/github/AUTHOR_NAME/PROJECT_NAME/badge.svg)](https://coveralls.io/github/AUTHOR_NAME/PROJECT_NAME)",
      "[![Coverage Status](https://coveralls.io/repos/"
    )
  end
end
