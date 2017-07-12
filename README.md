# InnerCotton

**TODO: Add description**

## Installation

Add `inner_cotton` to your list of dependencies in `mix.exs`:

```elixir
def deps do
  # [{:inner_cotton, "~> 0.1", only: [:dev, :test], runtime: false}]
  [{:inner_cotton, github: "ne-sachirou/inner_cotton", only: [:dev, :test], runtime: false}]
end
```

`mix deps.get` then you can run every checks by:

```sh
mix cotton.lint
```

<!--
Documentation can be generated with [ExDoc](https://github.com/elixir-lang/ex_doc)
and published on [HexDocs](https://hexdocs.pm). Once published, the docs can
be found at [https://hexdocs.pm/inner_cotton](https://hexdocs.pm/inner_cotton).
-->
