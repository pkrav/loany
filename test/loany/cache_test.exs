defmodule Loany.CacheTest do
  use ExUnit.Case

  describe "simple cache test" do
    test "initialization and init cache value" do
      assert 0 == Loany.Cache.get(:min_loan_amount)
    end

    test "change min cache value" do
      Loany.Cache.put(473)
      assert 473 == Loany.Cache.get(:min_loan_amount)
    end
  end
end
