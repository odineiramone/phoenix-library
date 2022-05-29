defmodule PhoenixLibrary.Books do
  alias PhoenixLibrary.{Books.Book, Repo}

  def create(params) do
    Book.create_changeset(params)
    |> Repo.insert()
  end

  def read(uuid) do
    case Repo.get(Book, uuid) do
      nil -> {:error, "Not found!"}
      data -> {:ok, data}
    end
  end

  def update(%{"id" => id} = params) do
    case read(id) do
      {:error, "Not found!"} -> {:error, "Not found!"}
      {:ok, entity} -> update_entity(entity, params)
    end
  end

  def delete(id) do
    case read(id) do
      {:error, "Not found!"} -> {:error, "Not found!"}
      {:ok, book} -> Repo.delete(book)
    end
  end

  def all do
    Book
    |> Repo.all()
  end

  defp update_entity(entity, params) do
    entity
    |> Book.update_changeset(params)
    |> Repo.update()
  end
end
