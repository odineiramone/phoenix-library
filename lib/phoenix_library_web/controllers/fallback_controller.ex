defmodule PhoenixLibraryWeb.FallbackController do
  use PhoenixLibraryWeb, :controller

  def call(conn, {:error, :not_found}), do: not_found(conn)

  def call(conn, {:error, %Ecto.Changeset{} = changeset}), do: validations_issues(conn, changeset)

  defp validations_issues(conn, changeset) do
    conn
    |> put_status(:bad_request)
    |> put_view(PhoenixLibraryWeb.ErrorView)
    |> render("400.json", changeset: changeset)
  end

  defp not_found(conn) do
    conn
    |> put_status(:not_found)
    |> put_view(PhoenixLibraryWeb.ErrorView)
    |> render("404.json", message: "Not found!")
  end
end
