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
  @spec run([binary]) :: any
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
    File.touch(".travis.yml")

    config =
      case Decoder.read_from_file(".travis.yml") do
        [] -> %{}
        config -> config
      end

    yaml =
      "language: elixir\n" <>
        (config
         |> Map.delete("language")
         |> Map.merge(%{
           "elixir" => ~w(
          1.5.3
          1.6.0
        ),
           "otp_release" => ~w(
          19.3
          20.1
        )
         })
         |> RelaxYaml.encode!())

    File.write!(".travis.yml", yaml)
  end
end
