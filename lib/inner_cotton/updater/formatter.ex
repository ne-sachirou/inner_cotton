defmodule InnerCotton.Updater.Formatter do
  @moduledoc """
  Init or update `.formatter.exs`.
  """

  alias InnerCotton.Updater

  @behaviour Updater

  @impl Updater
  def update do
    IO.puts("Initialize .formatter.exs")

    unless File.exists?(".formatter.exs") do
      File.write!(".formatter.exs", """
      [
        inputs: ["mix.exs", "{config,lib,test}/**/*.{ex,exs}"],
        export: [
          line_length: 120,
          locals_without_parens: []
        ],
      ]
      """)
    end
  end
end
