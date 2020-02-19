[![Actions Status](https://github.com/ne-sachirou/inner_cotton/workflows/test/badge.svg)](https://github.com/ne-sachirou/inner_cotton/actions)
[![Build Status](https://travis-ci.com/ne-sachirou/inner_cotton.svg?branch=master)](https://travis-ci.org/ne-sachirou/inner_cotton)
[![Coverage Status](https://coveralls.io/repos/github/ne-sachirou/inner_cotton/badge.svg)](https://coveralls.io/github/ne-sachirou/inner_cotton)
[![Hex.pm](https://img.shields.io/hexpm/v/inner_cotton.svg)](https://hex.pm/packages/inner_cotton)
[![Pipelines](https://gitlab.com/ne_sachirou/inner_cotton/badges/master/pipeline.svg)](https://gitlab.com/ne_sachirou/inner_cotton/pipelines)

# InnerCotton

Collection of recommended Elixir check utilities, and mix tasks to help initializing and maintaining OSS/production codes.

InnerCotton is a collection of recommended Elixir check utilities. It contains,

- [Credo][credo] : Lint, coding style enhancer.
- [Dialyxir][dialyxir] : Type checker using Dialyzer.
- [ExCoveralls][excoveralls] : Mesure test coverage.
- [EyeDrops][eyedrops] : File change watcher.
- [GitHub Actions][github actions] : GitHub bundled CI/CD.
- [GitLab CI][gitlab ci] : GitLab bundled CI/CD.
- [InchEx][inchex] : Document (ExDoc) improver.
- [Travis CI][travis ci] : Most widly used CI/CD for OSS.
- [mix format][formatter] : Community standard code formatter.
- [stream_data][stream_data] : Property base testing like QuickCheck.

## Installation

Add `inner_cotton` to your list of dependencies in `mix.exs`:

```elixir
def deps do
  [
    {:inner_cotton, "~> 0.6", only: [:dev, :test]},
    # {:inner_cotton, github: "ne-sachirou/inner_cotton", only: [:dev, :test]},
  ]
end
```

& run,

```sh
mix deps.get
mix cotton.init
mix cotton.init.github
```

`mix cotton.init.gitlab` & `mix cotton.init.travisci` are also available.

Then InnerCotton is installed & some configuration files are generated.

## Lint

```sh
mix cotton.lint
```

runs all checks. Now InnerCotton runs [`mix format --check-formatted`][formatter], [`mix credo --strict`][credo], [`mix dialyzer`][dialyxir] & [`mix inch --pedantic`][inchex].

```sh
mix cotton.lint --fix
```

auto correct errors if available.

## Test

InnerCotton installs [stream_data][stream_data] in your project. You can use it in your test.

```sh
mix test
MIX_ENV=test mix coveralls
```

## Watch

Watch file changes then run lint & test.

```sh
mix cotton.watch
```

## Update InnerCotton

Edit your `mix.exs` & run,

```sh
mix deps.update inner_cotton
mix cotton.init
mix cotton.init.github
```

`mix cotton.init.gitlab` & `mix cotton.init.travisci` are also available.

## CONTRIBUTING

[Maintenance policy](https://github.com/ne-sachirou/inner_cotton/wiki/Maintenance-policy)

[credo]: https://hex.pm/packages/credo
[dialyxir]: https://hex.pm/packages/dialyxir
[excoveralls]: https://hex.pm/packages/excoveralls
[eyedrops]: https://hex.pm/packages/eye_drops
[formatter]: https://hexdocs.pm/elixir/Code.html#format_string!/2
[github actions]: https://github.co.jp/features/actions
[gitlab ci]: https://about.gitlab.com/stages-devops-lifecycle/continuous-integration/
[inchex]: https://hex.pm/packages/inch_ex
[stream_data]: https://hex.pm/packages/stream_data
[travis ci]: https://travis-ci.com/
