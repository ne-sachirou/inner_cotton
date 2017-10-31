InnerCotton
==
Elixir Lint & test collection.

[![Hex.pm](https://img.shields.io/hexpm/v/inner_cotton.svg)](https://hex.pm/packages/inner_cotton)
[![Build Status](https://travis-ci.org/ne-sachirou/inner_cotton.svg?branch=master)](https://travis-ci.org/ne-sachirou/inner_cotton)

InnerCotton is a collection of recommended Elixir check utilities. It contains,

* [Credo][Credo] : Lint, coding style enhancer.
* [Dialyxir][Dialyxir] : Type checker using Dialyzer.
* [InchEx][InchEx] : Document (ExDoc) improver.
* [PropCheck][PropCheck] : Property base testing like QuickCheck.

Installation
--

Add `inner_cotton` to your list of dependencies in `mix.exs`:

```elixir
def deps do
  [
    {:inner_cotton, "~> 0.1", only: [:dev, :test]},
    # {:inner_cotton, github: "ne-sachirou/inner_cotton", only: [:dev, :test]},
  ]
end
```

& run,

```sh
mix deps.get
mix cotton.init
```

Then InnerCotton is installed & some configuration files are generated.

Lint
--
```sh
mix cotton.lint
```

runs all checks. Now InnerCotton runs [`mix credo --strict`][Credo], [`mix dialyzer`][Dialyxir] & [`mix inch --pedantic`][InchEx].

Test
--
InnerCotton installs [PropCheck][PropCheck] in your project. You can use it in your test.

Update InnerCotton
--
Edit your `mix.exs` & run,

```sh
mix deps.update inner_cotton
mix cotton.init
```

CONTRIBUTING
--
1. Fork.
1. Implement a new feature & write some tests.
1. Create a Pull Request.

Please run lint & test before commit.
```sh
mix cotton.lint
mix test
```

[Credo]: https://hex.pm/packages/credo
[Dialyxir]: https://hex.pm/packages/dialyxir
[InchEx]: https://hex.pm/packages/inch_ex
[PropCheck]: https://hex.pm/packages/propcheck
