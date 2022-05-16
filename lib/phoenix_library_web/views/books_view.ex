defmodule PhoenixLibraryWeb.BooksView do
  use PhoenixLibraryWeb, :view

  def render("index.json", %{books: books}) do
    %{
      status: "success",
      data: %{books: Enum.map(books, &book_json/1)}
    }
  end

  def render("show.json", %{book: book}) do
    %{
      status: "success",
      data: %{book: book_json(book)}
    }
  end

  def render("delete.json", %{message: message}) do
    %{
      status: "success",
      data: %{message: message}
    }
  end

  defp book_json(book) do
    %{
      title: book.title,
      id: book.id,
      publisher: book.publisher,
      authorship: book.authorship,
      cover_photo_url: book.cover_photo,
      inserted_at: book.inserted_at,
      updated_at: book.updated_at
    }
  end
end

