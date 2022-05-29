defmodule PhoenixLibraryWeb.BooksController do
  use PhoenixLibraryWeb, :controller

  alias PhoenixLibrary.Book

  action_fallback PhoenixLibraryWeb.FallbackController

  def index(conn, _params) do
    render(conn, "index.json", books: Book.all())
  end

  def show(conn, %{"id" => id}) do
    with {:ok, %Book{} = book} <- Book.read(id) do
      render(conn, "show.json", book: book)
    end
  end

  def create(conn, params) do
    with {:ok, %Book{} = book} <- Book.create(params) do
      render(conn, "show.json", book: book)
    end
  end

  def delete(conn, %{"id" => id}) do
    with {:ok, %Book{}} <- Book.delete(id) do
      render(conn, "delete.json", message: "Book deleted!")
    end
  end

  def update(conn, params) do
    with {:ok, %Book{} = book} <- Book.update(params) do
      render(conn, "show.json", book: book)
    end
  end
end
