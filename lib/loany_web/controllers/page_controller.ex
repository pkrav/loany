defmodule LoanyWeb.PageController do
  use LoanyWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
