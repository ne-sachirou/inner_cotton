defmodule InnerCotton.Mixfile do
  use Mix.Project

  def project do
    [
      app: :inner_cotton,
      build_embedded: Mix.env == :prod,
      deps: deps(),
      description: "Collection of recommended Elixir check utilities.",
      dialyzer: [
        ignore_warnings: "dialyzer.ignore-warnings",
        plt_add_apps: [:mix],
      ],
      elixir: "~> 1.4",
      package: package(),
      start_permanent: Mix.env == :prod,
      version: "0.1.0",

      # Docs
      docs: [
        main: "readme",
        extras: ["README.md"],
      ],
      homepage_url: "https://github.com/ne-sachirou/inner_cotton",
      name: "Inner_Cotton",
      source_url: "https://github.com/ne-sachirou/inner_cotton",
    ]
  end

  def application, do: [extra_applications: []]

  defp deps do
    [
      {:credo, "~> 0.8", runtime: false},
      {:dialyxir, "~> 0.5", runtime: false},
      {:ex_doc, "~> 0.16", only: :dev, runtime: false},
      {:inch_ex, "~> 0.5", runtime: false},
      {:relax_yaml, "~> 0.1", runtime: false},
      {:stream_data, "~> 0.1"},
    ]
  end

  def package do
    [
      files: ["LICENSE", "README.md", "mix.exs", "lib"],
      licenses: ["GPL-3.0"],
      links: %{
        "GitHub": "https://github.com/ne-sachirou/inner_cotton",
      },
      maintainers: ["ne_Sachirou <utakata.c4se@gmail.com>"],
      name: :inner_cotton,
    ]
  end
end
