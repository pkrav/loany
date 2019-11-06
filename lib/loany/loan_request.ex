defmodule Loany.LoanRequest do
  use Ecto.Schema
  import Ecto.Changeset
  alias Loany.LoanRequest

  @phone ~r/^(\+\d{1,2}[\s.-]?)?\(?\d{3}\)?[\s.-]?\d{3}[\s.-]?\d{2}[\s.-]?\d{2}$/
  @email ~r/[A-Z0-9._%+-]+@[A-Z0-9.-]+\.[A-Z]{2,}/iu

  @primary_key {:id, :binary_id, autogenerate: true}
  schema "loan_requests" do
    field(:amount, :integer)
    field(:name, :string)
    field(:phone, :string)
    field(:email, :string)
    field(:status, :boolean)
    field(:interest_rate, :decimal)

    timestamps()
  end

  def changeset(%LoanRequest{} = loan_request, attrs \\ %{}) do
    loan_request
    |> cast(attrs, [:amount, :name, :phone, :email, :status, :interest_rate])
    |> validate_required([:amount, :name, :phone, :email])
    |> validate_number(:amount, greater_than: 0, message: "Amount should be greater than zero!")
    |> validate_format(:phone, @phone, message: "Invalid phone number!")
    |> validate_format(:email, @email, message: "Invalid email address!")
  end
end
