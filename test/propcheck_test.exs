defmodule InnerCotton.PropCheckTest do
  use ExUnit.Case
  use PropCheck

  property "PropCheck is enabled" do
    forall i <- integer(), do: assert is_integer(i)
  end
end
