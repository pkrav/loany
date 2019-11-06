defmodule LoanyWeb.LoanRequestController do
  use LoanyWeb, :controller

  alias Loany.Repo
  alias Loany.LoanRequest
  alias Loany.Scoring

  def new(conn, _params) do
    changeset = LoanRequest.changeset(%LoanRequest{})
    render(conn, "new.html", changeset: changeset)
  end

  def index(conn, _params) do
    loan_requests = LoanRequest |> Repo.all()
    render(conn, "index.html", loan_requests: loan_requests)
  end

  def show(conn, %{"id" => id}) do
    with loan_request <- LoanRequest |> Repo.get(id),
         true <- loan_request.status do
      render(conn, "offer.html", loan_request: loan_request)
    else
      false ->
        render(conn, "rejected.html")

      {:error, reason} ->
        {:error, reason}
    end
  end

  def create(conn, %{"loan_request" => loan_request}) do
    with {:ok, status, rate} <- loan_request |> Scoring.application_scoring(),
         changeset <- get_changeset(loan_request, status, rate),
         {:ok, loan_request_record} <- changeset |> Repo.insert() do
      redirect(
        conn,
        to: Routes.loan_request_path(conn, :show, loan_request_record.id)
      )
    else
      {:error, changeset} ->
        render(conn, :new, changeset: changeset)
    end
  end

  defp get_changeset(loan_request, status, rate) do
    %LoanRequest{}
    |> LoanRequest.changeset(
      Map.merge(
        loan_request,
        %{"status" => status, "interest_rate" => rate}
      )
    )
  end
end
