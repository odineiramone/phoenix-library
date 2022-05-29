defmodule PhoenixLibrary.Books do
  alias PhoenixLibrary.{Books.Book, Repo}

  def create_book(params) do
    params
    |> Book.create_changeset()
    |> Repo.insert()
  end

  def load_book(uuid) do
    case Repo.get(Book, uuid) do
      nil -> {:error, "Not found!"}
      data -> {:ok, data}
    end
  end

  def update_book(%{"id" => id} = params) do
    case load_book(id) do
      {:error, "Not found!"} -> {:error, "Not found!"}
      {:ok, entity} -> update_entity(entity, params)
    end
  end

  def delete_book(id) do
    case load_book(id) do
      {:error, "Not found!"} -> {:error, "Not found!"}
      {:ok, book} -> Repo.delete(book)
    end
  end

  def list_books do
    Book
    |> Repo.all()
  end

  defp update_entity(entity, params) do
    entity
    |> Book.update_changeset(params)
    |> Repo.update()
  end
end
