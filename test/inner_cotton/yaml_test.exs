defmodule InnerCotton.YamlTest do
  alias InnerCotton.Yaml

  use ExUnit.Case

  setup_all do: {:ok, _} = Application.ensure_all_started(:fast_yaml)

  describe "decode_from_file/2" do
    for {expected, input} <- [
          {1, "1"},
          {"x", "x"},
          {[], "[]"},
          {[1], "- 1"},
          {[], "{}"},
          {%{x: 1}, "{x: 1}"},
          {%{x: 1}, ~s({"x": 1})}
        ] do
      @tag expected: expected, input: input
      test inspect(input), %{expected: expected, input: input} do
        File.cd!(System.tmp_dir!(), fn ->
          tmp_file = 16 |> :crypto.strong_rand_bytes() |> Base.url_encode64(padding: false)

          try do
            File.write!(tmp_file, input)
            assert [expected] == Yaml.decode_from_file(tmp_file)
          after
            File.rm!(tmp_file)
          end
        end)
      end
    end
  end

  describe "encode/1" do
    for {expected, input} <- [
          {"nil", nil},
          {"x", :x},
          {"1", 1},
          {~s(""), ""},
          {~s("x"), "x"},
          {"[]", []},
          {"- 1", [1]},
          {"[]", %{}},
          {"x: 1", %{x: 1}},
          {~s("x": 1), %{"x" => 1}}
        ] do
      @tag expected: expected, input: input
      test inspect(input), %{expected: expected, input: input} do
        assert expected == input |> Yaml.encode() |> to_string
      end
    end
  end
end
