# InnerCotton
Elixir Lint & test collection.

[![Hex.pm](https://img.shields.io/hexpm/v/unner_cotton.svg)](https://hex.pm/packages/unner_cotton)

## Installation

Add `inner_cotton` to your list of dependencies in `mix.exs`:

```elixir
def deps do
  [{:inner_cotton, "~> 0.1", only: [:dev, :test]}]
  # [{:inner_cotton, github: "ne-sachirou/inner_cotton", only: [:dev, :test]}]
end
```

& `mix deps.get`.

List
--
```sh
mix cotton.lint
```

runs all checks. Now InnerCotton runs :

* [Credo](https://hex.pm/packages/credo)
* [Dialyxir](https://hex.pm/packages/dialyxir)
* [InchEx](https://hex.pm/packages/inch_ex)

## Test
InnerCotton installs [PropCheck](https://hex.pm/packages/propcheck) in your project. You can use it in your test.

## CONTRIBUTING
```sh
mix cotton.lint
mix test
```
