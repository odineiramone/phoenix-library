defmodule PhoenixLibraryWeb.BooksController do
  use PhoenixLibraryWeb, :controller

  alias PhoenixLibrary.{Books, Books.Book}

  action_fallback PhoenixLibraryWeb.FallbackController

  def index(conn, _params) do
    render(conn, "index.json", books: Books.list_books())
  end

  def show(conn, %{"id" => id}) do
    with {:ok, %Book{} = book} <- Books.find_book(id) do
      render(conn, "show.json", book: book)
    end
  end

  def create(conn, params) do
    with {:ok, %Book{} = book} <- Books.create_book(params) do
      render(conn, "show.json", book: book)
    end
  end

  def delete(conn, %{"id" => id}) do
    with {:ok, %Book{}} <- Books.delete_book(id) do
      render(conn, "delete.json", message: "Book deleted!")
    end
  end

  def update(conn, params) do
    with {:ok, %Book{} = book} <- Books.update_book(params) do
      render(conn, "show.json", book: book)
    end
  end
end
