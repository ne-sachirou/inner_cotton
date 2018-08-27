defmodule Mix.Tasks.Cotton.Init do
  @moduledoc """
  Initialize or update config files.

  * .credo.exs
  * .gitignore
  * .travis.yml
  """

  alias RelaxYaml.Decoder

  use Mix.Task

  @shortdoc "Initialize or update config files"

  @doc """
  Initialize or update config files.
  """
  @impl true
  def run(_args) do
    init_credo()
    init_formatter()
    init_gitignore()
    init_travis()
  end

  defp init_credo do
    IO.puts("Initialize .credo.exs")

    case File.rm(".credo.exs") do
      :ok -> nil
      {:error, :enoent} -> nil
      {:error, reason} -> raise "`rm .credo.exs` : #{reason}"
    end

    Mix.Task.run("credo.gen.config")
  end

  defp init_formatter do
    IO.puts("Initialize .formatter.exs")

    unless File.exists?(".formatter.exs") do
      File.write!(".formatter.exs", """
      [
        inputs: ["mix.exs", "{config,lib,test}/**/*.{ex,exs}"],
        export: [
          line_length: 80,
          locals_without_parens: []
        ],
      ]
      """)
    end
  end

  defp init_gitignore do
    IO.puts("Initialize .gitignore")
    File.touch(".gitignore")
    config = File.read!(".gitignore")

    config =
      if String.match?(config, ~r{^/docs$}m) do
        config
      else
        config <> "\n/docs\n"
      end

    File.write!(".gitignore", config)
  end

  defp init_travis do
    IO.puts("Initialize .travis.yml")
    {:ok, _} = Application.ensure_all_started(:yamerl)
    File.touch!(".travis.yml")

    config =
      case Decoder.read_from_file(".travis.yml") do
        [] -> %{}
        config -> config
      end

    config =
      Map.merge(config, %{
        "elixir" => ~w(1.6 1.7),
        "otp_release" => ~w(20.3 21.0)
      })

    config =
      if get_in(config, ["matrix", "exclude"]) do
        config
        |> pop_in([
          "matrix",
          "exclude",
          Access.filter(&match?(%{"elixir" => "1.5.3", "otp_release" => "21.0"}, &1))
        ])
        |> elem(1)
      else
        config
      end

    yaml = "language: elixir\n" <> (config |> Map.delete("language") |> RelaxYaml.encode!(config))
    File.write!(".travis.yml", yaml)
  end
end
