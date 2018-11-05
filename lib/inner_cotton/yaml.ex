defmodule InnerCotton.Yaml do
  @moduledoc """
  Convenient wrapper of `:fast_yaml`.
  """

  @type t :: term

  @doc """
  `:fast_yaml.load_from_file/2`
  """
  @spec decode_from_file(Path.t(), :fast_yaml.options()) :: t
  def decode_from_file(file, opts \\ []) do
    docs =
      case file |> to_charlist() |> :fast_yaml.decode_from_file(opts) do
        {:ok, docs} -> docs
        _ -> []
      end

    Enum.map(docs, &erl_to_ex/1)
  end

  @doc """
  `:fast_yaml.encode/1`
  """
  @spec encode(t) :: iolist
  def encode(term), do: term |> ex_to_erl |> :fast_yaml.encode()

  defp erl_to_ex(erl_term) when is_list(erl_term) and [] != erl_term do
    if Enum.all?(erl_term, &match?({k, _} when is_binary(k) or is_atom(k), &1)) do
      erl_term
      |> update_in([Access.all()], fn {k, v} ->
        k = if is_binary(k), do: String.to_atom(k), else: k
        {k, erl_to_ex(v)}
      end)
      |> Map.new()
    else
      Enum.map(erl_term, &erl_to_ex/1)
    end
  end

  defp erl_to_ex(erl_term), do: erl_term

  defp ex_to_erl(ex_term) when is_map(ex_term),
    do: ex_term |> Enum.to_list() |> update_in([Access.all(), Access.elem(1)], &ex_to_erl/1)

  defp ex_to_erl(ex_term) when is_list(ex_term), do: Enum.map(ex_term, &ex_to_erl/1)
  defp ex_to_erl(ex_term), do: ex_term
end
