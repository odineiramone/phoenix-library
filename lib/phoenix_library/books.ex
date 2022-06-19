defmodule PhoenixLibrary.Books do
  @moduledoc """
  Fornece funções para manipular registros de Book no banco de dados:

  - Função `create_book/1` para criar um novo livro.
  - Função `load_book/1` para carregar um livro existente.
  - Função `update_book/1` para atualizar um livro existente.
  - Função `delete_book/1` para deletar um livro existente.
  - Função `list_books/0` para listar todos os livros existentes no banco de dados.
  - Função `by_title/1` para pesquisar livros por título.
  - Função `by_authorship/1` para pesquisar livros por autoria.
  """

  import Ecto.Query, only: [from: 2]

  alias PhoenixLibrary.{Books.Book, Repo}

  def create_book(params) do
    params
    |> Book.create_changeset()
    |> Repo.insert()
  end

  def load_book(uuid) do
    case Repo.get(Book, uuid) do
      nil -> {:error, :not_found}
      data -> {:ok, data}
    end
  end

  def update_book(%{"id" => id} = params) do
    case load_book(id) do
      {:error, :not_found} -> {:error, :not_found}
      {:ok, entity} -> update_entity(entity, params)
    end
  end

  def delete_book(id) do
    case load_book(id) do
      {:error, :not_found} -> {:error, :not_found}
      {:ok, book} -> Repo.delete(book)
    end
  end

  def list_books do
    Book
    |> Repo.all()
  end

  def by_title(search_term) do
    wildcard_search = "%#{search_term}%"

    from(book in Book, where: ilike(book.title, ^wildcard_search))
    |> Repo.all()
  end

  def by_authorship(search_term) do
    wildcard_search = "%#{search_term}%"

    from(book in Book,
      where: ilike(fragment("ARRAY_TO_STRING(?, ',')", book.authorship), ^wildcard_search)
    )
    |> Repo.all()
  end

  defp update_entity(entity, params) do
    entity
    |> Book.update_changeset(params)
    |> Repo.update()
  end
end
