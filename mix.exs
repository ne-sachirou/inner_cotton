defmodule InnerCotton.Mixfile do
  use Mix.Project

  def project do
    [
      app: :inner_cotton,
      version: "0.1.0",
      elixir: "~> 1.4",
      build_embedded: Mix.env == :prod,
      start_permanent: Mix.env == :prod,
      deps: deps(),
      aliases: aliases(),
      dialyzer: [
        ignore_warnings: "dialyzer.ignore-warnings",
      ],
    ]
  end

  def application, do: [extra_applications: []]

  defp deps do
    [
      {:credo, "~> 0.8", runtime: false},
      {:dialyxir, "~> 0.5", runtime: false},
      {:inch_ex, "~> 0.5", runtime: false},
      {:propcheck, "~> 1.0", runtime: false},
    ]
  end

  defp aliases do
    [
      "lint": ["cotton.lint"],
    ]
  end
end
