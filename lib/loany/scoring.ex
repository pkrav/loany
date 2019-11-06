defmodule Loany.Scoring do
  alias Loany.Cache

  @lower_bound 4
  @upper_bound 12

  def application_scoring(%{"amount" => amount}) do
    amount = amount |> String.to_integer()

    if amount >= Cache.get(:min_loan_amount) do
      {:ok, rate} = get_interest_rate(amount)
      {:ok, true, rate}
    else
      Cache.put(amount)
      {:ok, false, 0}
    end
  end

  defp get_interest_rate(amount) do
    if is_prime?(amount) do
      {:ok, 9.99}
    else
      {
        :ok,
        (@lower_bound + :rand.uniform() * (@upper_bound - @lower_bound))
        |> Decimal.from_float()
        |> Decimal.round(2)
      }
    end
  end

  def is_prime?(val) when val in [2, 3], do: true

  def is_prime?(val) do
    sqrt = :math.sqrt(val) |> Float.floor() |> round
    composite? = &(rem(val, &1) == 0)

    !Enum.any?(2..sqrt, composite?)
  end
end
