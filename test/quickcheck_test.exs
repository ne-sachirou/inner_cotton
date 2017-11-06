defmodule InnerCotton.QuickCheckTest do
  use ExUnit.Case
  use ExUnitProperties

  property "QuickCheck is enabled" do
    check all i <- integer() do
      assert is_integer(i)
    end
  end
end
