InnerCotton
==
Collection of recommended Elixir check utilities.

[![Hex.pm](https://img.shields.io/hexpm/v/inner_cotton.svg)](https://hex.pm/packages/inner_cotton)
[![Build Status](https://travis-ci.org/ne-sachirou/inner_cotton.svg?branch=master)](https://travis-ci.org/ne-sachirou/inner_cotton)
[![Coverage Status](https://coveralls.io/repos/github/ne-sachirou/inner_cotton/badge.svg)](https://coveralls.io/github/ne-sachirou/inner_cotton)

InnerCotton is a collection of recommended Elixir check utilities. It contains,

* [Credo][Credo] : Lint, coding style enhancer.
* [Dialyxir][Dialyxir] : Type checker using Dialyzer.
* [ExCoveralls][ExCoveralls] : Mesure test coverage.
* [EyeDrops][EyeDrops] : File change watcher.
* [InchEx][InchEx] : Document (ExDoc) improver.
* [mix format][formatter] : Community standard code formatter.
* [stream_data][stream_data] : Property base testing like QuickCheck.

Installation
--
Add `inner_cotton` to your list of dependencies in `mix.exs`:

```elixir
def deps do
  [
    {:inner_cotton, "~> 0.3", only: [:dev, :test]},
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

runs all checks. Now InnerCotton runs [`mix format --check-formatted`][formatter], [`mix credo --strict`][Credo], [`mix dialyzer`][Dialyxir] & [`mix inch --pedantic`][InchEx].

```sh
mix cotton.lint --fix
```

auto correct errors if available.

Test
--
InnerCotton installs [stream_data][stream_data] in your project. You can use it in your test.

```sh
mix test
MIX_ENV=test mix coveralls
```

Watch
--
Watch file changes then run lint & test.

```sh
mix cotton.watch
```

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
[ExCoveralls]: https://hex.pm/packages/excoveralls
[EyeDrops]: https://hex.pm/packages/eye_drops
[formatter]: https://hexdocs.pm/elixir/Code.html#format_string!/2
[InchEx]: https://hex.pm/packages/inch_ex
[stream_data]: https://hex.pm/packages/stream_data
