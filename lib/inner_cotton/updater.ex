defmodule InnerCotton.Updater do
  @moduledoc """
  Init or update a dev resource. Called from `mix cotton.init`.
  """

  @doc """
  Init or update a dev resource. `update/0` must be idempotent.
  """
  @callback update :: any
end
