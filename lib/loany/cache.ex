defmodule Loany.Cache do
  use GenServer

  alias Loany.Repo
  alias Loany.LoanRequest

  import Ecto.Query

  ## Client API

  @doc """
  Starts the cache.
  """
  def start_link(_) do
    GenServer.start_link(__MODULE__, 0, name: __MODULE__)
  end

  def get(key) do
    GenServer.call(__MODULE__, key)
  end

  def put(amount) do
    GenServer.cast(__MODULE__, {:put, amount})
  end

  ## Defining GenServer Callbacks

  @doc """
  Cache initialize with min value from DB if such value exists and with
  0 otherwise.
  """
  @impl true
  def init(_) do
    LoanRequest
    |> select([p], min(p.amount))
    |> Repo.one()
    |> case do
      nil ->
        {:ok, %{min_amount: 0}}

      amount ->
        {:ok, %{min_amount: amount}}
    end
  end

  @impl true
  def handle_call(:min_loan_amount, _from, %{min_amount: min_amount} = state) do
    {:reply, min_amount, state}
  end

  @doc """
  If cache initialization was done with 0 then cache value
  should be changed to the first amount obtained as we would like to allow to
  get any loan at first try, but not during next one.
  """
  @impl true
  def handle_cast({:put, amount}, %{min_amount: min_amount} = state) do
    if min_amount == 0 or amount < min_amount do
      {:noreply, %{state | min_amount: amount}}
    else
      {:noreply, state}
    end
  end
end
