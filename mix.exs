defmodule InnerCotton.Mixfile do
  use Mix.Project

  def project do
    [
      app: :inner_cotton,
      build_embedded: Mix.env() == :prod,
      deps: deps(Mix.env()),
      description: "Collection of recommended Elixir check utilities.",
      dialyzer: [
        ignore_warnings: "dialyzer.ignore-warnings",
        plt_add_apps: [:mix],
        plt_core_path: "_build",
        remove_defaults: [:unknown]
      ],
      elixir: "~> 1.9",
      package: package(),
      preferred_cli_env: [
        coveralls: :test,
        "coveralls.detail": :test,
        "coveralls.github": :test,
        "coveralls.html": :test
      ],
      start_permanent: Mix.env() == :prod,
      test_coverage: [tool: ExCoveralls],
      version: "0.6.0",

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

  defp deps(:publish) do
    [
      {:credo, "~> 1.0", runtime: false},
      {:dialyxir, "~> 0.5", runtime: false},
      {:excoveralls, "~> 0.9"},
      {:eye_drops, "~> 1.3", runtime: false},
      {:inch_ex, "~> 2.0", runtime: false},
      {:stream_data, "~> 0.4"}
    ]
  end

  defp deps(_) do
    [
      {:ex_doc, "~> 0.19", only: :dev, runtime: false}
      | deps(:publish)
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
