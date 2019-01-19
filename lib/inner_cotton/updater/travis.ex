defmodule InnerCotton.Updater.Travis do
  @moduledoc """
  Init or update `.travis.yml`.
  """

  alias InnerCotton.Updater
  alias InnerCotton.Yaml

  @behaviour Updater

  @config_file ".travis.yml"

  @impl Updater
  def update do
    IO.puts("Initialize .travis.yml")
    {:ok, _} = Application.ensure_all_started(:fast_yaml)
    File.touch!(@config_file)
    [config] = Yaml.decode_from_file(@config_file)

    config =
      config
      |> Map.merge(%{elixir: ~w(1.7 1.8), otp_release: ~w(20.3 21.2)})
      |> rm_old_matrix_exclude_153
      |> add_coveralls_travis

    yaml = ["language: elixir\n" | config |> Map.delete(:language) |> Yaml.encode()]
    File.write!(@config_file, yaml)
  end

  defp rm_old_matrix_exclude_153(config) do
    if get_in(config, [:matrix, :exclude]) do
      config
      |> pop_in([
        :matrix,
        :exclude,
        Access.filter(&(&1[:elixir] == "1.5.3" and &1[:otp_release] == "21.0"))
      ])
      |> elem(1)
    else
      config
    end
  end

  defp add_coveralls_travis(config) do
    update_in(config, [Access.key(:script, [])], fn script ->
      script =
        put_in(
          script,
          [Access.filter(&Regex.match?(~r/^mix test|(?:coveralls(?:\.[a-z]+)?)$/, &1))],
          "mix coveralls.travis"
        )

      if Enum.any?(script, &String.starts_with?(&1, "mix coveralls.travis")),
        do: script,
        else: script ++ ["mix coveralls.travis"]
    end)
  end
end
