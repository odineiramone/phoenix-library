defmodule PhoenixLibraryWeb.BooksController do
  use PhoenixLibraryWeb, :controller

  alias PhoenixLibrary.Book

  def index(conn, _params) do
    render conn, "index.json", books: Book.all
  end

  def show(conn, %{"id" => id}) do
    render conn, "show.json", book: Book.read(id)
  end
end
