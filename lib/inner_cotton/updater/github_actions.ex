defmodule InnerCotton.Updater.GitHubActions do
  @moduledoc """
  Init or update `.github/workflows/test.yml`.
  """

  alias InnerCotton.Updater

  @behaviour Updater

  @impl Updater
  def update do
    IO.puts("Initialize .github/workflows/test.yml")
    File.mkdir_p!(Path.join(File.cwd!(), ".github.workflows"))

    File.cp!(
      Path.join(:code.priv_dir(:inner_cotton), ".github-workflows-test.yml"),
      Path.join(File.cwd!(), ".github/workflows/test.yml")
    )
  end
end
