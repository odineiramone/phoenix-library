defmodule PhoenixLibraryWeb.BooksController do
  use PhoenixLibraryWeb, :controller

  alias PhoenixLibrary.Book

  def index(conn, _params) do
    render conn, "index.json", books: Book.all
  end

  def show(conn, %{"id" => id}) do
    render conn, "show.json", book: Book.read(id)
  end

  def create(conn, params) do
    {:ok, book} = Book.create(params)

    render conn, "show.json", book: book
  end

  def delete(conn, %{"id" => id}) do
    Book.delete(id)

    render conn, "delete.json", message: "Book deleted!"
  end

  def update(conn, params) do
    {:ok, book} = Book.update(params)

    render conn, "show.json", book: book
  end
end
