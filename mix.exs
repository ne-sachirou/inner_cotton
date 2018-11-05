defmodule InnerCotton.Mixfile do
  use Mix.Project

  def project do
    [
      app: :inner_cotton,
      build_embedded: Mix.env() == :prod,
      deps: deps(),
      description: "Collection of recommended Elixir check utilities.",
      dialyzer: [
        flags: [:no_undefined_callbacks],
        ignore_warnings: "dialyzer.ignore-warnings",
        remove_defaults: [:unknown]
      ],
      elixir: "~> 1.6",
      package: package(),
      preferred_cli_env: [
        coveralls: :test,
        "coveralls.detail": :test,
        "coveralls.post": :test,
        "coveralls.travis": :test,
        "coveralls.html": :test
      ],
      start_permanent: Mix.env() == :prod,
      test_coverage: [tool: ExCoveralls],
      version: "0.3.1",

      # Docs
      docs: [
        main: "readme",
        extras: ["README.md"]
      ],
      homepage_url: "https://github.com/ne-sachirou/inner_cotton",
      name: "InnerCotton",
      source_url: "https://github.com/ne-sachirou/inner_cotton"
    ]
  end

  def application, do: [extra_applications: []]

  defp deps do
    [
      {:credo, "~> 0.10", runtime: false},
      {:dialyxir, "~> 0.5", runtime: false},
      {:excoveralls, "~> 0.9"},
      {:ex_doc, "~> 0.19", only: :dev, runtime: false},
      {:eye_drops, "~> 1.3", runtime: false},
      {:fast_yaml, "~> 1.0"},
      # {:inch_ex, "~> 1.0", runtime: false},
      # {:inch_ex, github: "rrrene/inch_ex", runtime: false},
      {:stream_data, "~> 0.4"}
    ]
  end

  def package do
    [
      files: ["LICENSE", "README.md", "mix.exs", "lib"],
      licenses: ["Unlicense"],
      links: %{
        GitHub: "https://github.com/ne-sachirou/inner_cotton"
      },
      maintainers: ["ne_Sachirou <utakata.c4se@gmail.com>"],
      name: :inner_cotton
    ]
  end
end
