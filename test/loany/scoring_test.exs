defmodule Loany.ScoringTest do
  use ExUnit.Case

  describe "application_scoring" do
    test "Empty cache" do
      {res, status, rate} = Loany.Scoring.application_scoring(%{"amount" => "170"})
      assert res == :ok
      assert status == true
      assert Decimal.lt?(4, rate) and Decimal.lt?(rate, 12)
    end

    test "Amount is prime number" do
      {res, status, rate} = Loany.Scoring.application_scoring(%{"amount" => "173"})
      assert res == :ok
      assert status == true
      assert rate == 9.99
    end
  end

  describe "is_prime?" do
    test "value is prime number" do
      assert Loany.Scoring.is_prime?(17)
    end

    test "value is not prime number" do
      refute Loany.Scoring.is_prime?(8)
    end
  end
end
