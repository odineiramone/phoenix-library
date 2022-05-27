defmodule PhoenixLibraryWeb.FallbackController do
  use PhoenixLibraryWeb, :controller

  def call(conn, {:error, "Not found!"} = error), do: not_found(conn, error)

  def call(conn, {:error, "No search parameters!"} = error), do: not_found(conn, error)

  def call(conn, {:error, %Ecto.Changeset{} = changeset}), do: validations_issues(conn, changeset)

  defp validations_issues(conn, changeset) do
    conn
    |> put_status(:bad_request)
    |> put_view(PhoenixLibraryWeb.ErrorView)
    |> render("400.json", changeset: changeset)
  end

  defp not_found(conn, error) do
    conn
    |> put_status(:not_found)
    |> put_view(PhoenixLibraryWeb.ErrorView)
    |> render("404.json", message: error)
  end
end
