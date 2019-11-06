defmodule Loany.Repo.Migrations.LoanRequests do
  use Ecto.Migration

  def change do
		create table(:loan_requests, primary_key: false) do
			add(:id, :uuid, null: false, primary_key: true)
			add :name, :string
			add :phone, :string
			add :email, :string
			add :amount, :integer
			add :status, :boolean
			add :interest_rate, :decimal

			timestamps()
		end
  end
end
