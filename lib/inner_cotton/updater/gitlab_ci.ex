defmodule InnerCotton.Updater.GitLabCI do
  @moduledoc """
  Init or update `.gitlab-ci.yml`.
  """

  alias InnerCotton.Updater

  @behaviour Updater

  @impl Updater
  def update do
    IO.puts("Initialize .gitlab-ci.yml")

    File.cp!(
      Path.join(:code.priv_dir(:inner_cotton), ".gitlab-ci.yml"),
      Path.join(File.cwd!(), ".gitlab-ci.yml")
    )
  end
end
