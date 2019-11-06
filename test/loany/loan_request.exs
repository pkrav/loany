defmodule Loany.LoanRequestTest do
  use ExUnit.Case

  @loan_request %{
    amount: 171,
    name: "John Doe",
    phone: "1234567890",
    email: "user@loany.se"
  }

  describe "tests for changeset validity" do
    test "fully valid loan request input data" do
      assert Loany.LoanRequest.changeset(
               %Loany.LoanRequest{},
               @loan_request
             ).valid? == true
    end

    test "invalid amount" do
      assert Loany.LoanRequest.changeset(
               %Loany.LoanRequest{},
               %{@loan_request | amount: -1}
             ).valid? == false
    end

    test "valid phone number with country code" do
      assert Loany.LoanRequest.changeset(
               %Loany.LoanRequest{},
               %{@loan_request | phone: "+12345678901"}
             ).valid? == true
    end

    test "valid phone number with brackets and country code" do
      assert Loany.LoanRequest.changeset(
               %Loany.LoanRequest{},
               %{@loan_request | phone: "+51(234)5678901"}
             ).valid? == true
    end

    test "valid phone number space separated" do
      assert Loany.LoanRequest.changeset(
               %Loany.LoanRequest{},
               %{@loan_request | phone: "123 456 78 90"}
             ).valid? == true
    end

    test "valid phone number dash separated" do
      assert Loany.LoanRequest.changeset(
               %Loany.LoanRequest{},
               %{@loan_request | phone: "123-456-78-90"}
             ).valid? == true
    end

    test "invalid character in phone number" do
      assert Loany.LoanRequest.changeset(
               %Loany.LoanRequest{},
               %{@loan_request | phone: "123456789q"}
             ).valid? == false
    end

    test "too short phone number" do
      assert Loany.LoanRequest.changeset(
               %Loany.LoanRequest{},
               %{@loan_request | phone: "123"}
             ).valid? == false
    end

    test "too long phone number" do
      assert Loany.LoanRequest.changeset(
               %Loany.LoanRequest{},
               %{@loan_request | phone: "12345678901"}
             ).valid? == false
    end

    test "invalid email" do
      assert Loany.LoanRequest.changeset(
               %Loany.LoanRequest{},
               %{@loan_request | email: "12345678901"}
             ).valid? == false
    end

    test "incomplete email without domain and domain zone" do
      assert Loany.LoanRequest.changeset(
               %Loany.LoanRequest{},
               %{@loan_request | email: "wer123@"}
             ).valid? == false
    end

    test "incomplete email without domain zone" do
      assert Loany.LoanRequest.changeset(
               %Loany.LoanRequest{},
               %{@loan_request | email: "abc.123.def@loan"}
             ).valid? == false
    end

    test "complete email" do
      assert Loany.LoanRequest.changeset(
               %Loany.LoanRequest{},
               %{@loan_request | email: "abc.123.def@loan.co.uk"}
             ).valid? == true
    end
  end
end
