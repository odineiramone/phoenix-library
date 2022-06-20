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

  @doc """
  Retorna uma tupla {:ok, <livro criado>} caso o livro seja criado com sucesso ou
  uma tupla {:erro, <changeset>} caso o livro não possa ser criado.

  ## Parâmetros

    - params: Map com dados para criar um novo livro no banco de dados.

  ## Exemplos

    iex> PhoenixLibrary.Books.create_book(%{
           title: "Adopting Elixir",
           publisher: "The Pragmatic Programmers",
           authorship: ["Ben Marx", "José Valim", "Bruce Tate"],
           cover_photo: "https://pragprog.com/titles/tvmelixir/adopting-elixir/tvmelixir.jpg"
         })

    {:ok, %PhoenixLibrary.Books.Book{...}}

    iex> PhoenixLibrary.Books.create_book(%{
           title: "Adopting Elixir"
         })

    {:error, #Ecto.Changeset<..., valid?: false>}
  """
  def create_book(params) do
    params
    |> Book.create_changeset()
    |> Repo.insert()
  end

  @doc """
  Retorna uma tupla {:ok, <livro>} caso o livro seja encontrado no banco de dados
  ou uma tupla {:erro, :not_found} caso o livro não possa ser encontrado.

  ## Parâmetros

    - uuid: id do livro a ser buscado no formato UUID.

  ## Exemplos

    iex> PhoenixLibrary.Books.load_book("0200e8de-69c0-4d88-982c-31721cb4af5c")

    {:ok, %PhoenixLibrary.Books.Book{...}}

    iex> PhoenixLibrary.Books.load_book("521675b8-df5d-495d-b579-4f2c69716318")

    {:error, #Ecto.Changeset<..., valid?: false>}
  """
  def load_book(uuid) do
    case Repo.get(Book, uuid) do
      nil -> {:error, :not_found}
      data -> {:ok, data}
    end
  end

  @doc """
  Retorna uma tupla {:ok, <livro>} caso o livro seja encontrado no banco de dados
  ou uma tupla {:erro, :not_found} caso o livro não possa ser encontrado.

  ## Parâmetros

    - params: Map com parametros a serem atualizados no livro. Deve conter uma chave
      "id" com o id do livro a ser atualizado.

  ## Exemplos

    iex> PhoenixLibrary.Books.update_book(%{
           "id" => "0200e8de-69c0-4d88-982c-31721cb4af5c",
           "title" => "Adopting Elixir - From Concept to Production"
         })

    {:ok, %PhoenixLibrary.Books.Book{...}}

    iex> PhoenixLibrary.Books.update_book(%{
           "id" => "521675b8-df5d-495d-b579-4f2c69716318",
           "title" => "Adopting Elixir - From Concept to Production"
         })

    {:error, :not_found}
  """
  def update_book(%{"id" => id} = params) do
    case load_book(id) do
      {:error, :not_found} -> {:error, :not_found}
      {:ok, entity} -> update_entity(entity, params)
    end
  end

  @doc """
  Retorna uma tupla {:ok, <livro>} caso o livro seja encontrado no banco de dados
  ou uma tupla {:erro, :not_found} caso o livro não possa ser encontrado.

  ## Parâmetros

    - id: id do livro a ser buscado no formato UUID.

  ## Exemplos

    iex> PhoenixLibrary.Books.delete_book("0200e8de-69c0-4d88-982c-31721cb4af5c")

    {:ok, %PhoenixLibrary.Books.Book{...}}

    iex> PhoenixLibrary.Books.update_book("521675b8-df5d-495d-b579-4f2c69716318")

    {:error, :not_found}
  """
  def delete_book(id) do
    case load_book(id) do
      {:error, :not_found} -> {:error, :not_found}
      {:ok, book} -> Repo.delete(book)
    end
  end

  @doc """
  Retorna uma lista com todos os livros cadastrados no banco de dados.

  ## Exemplos

    iex> PhoenixLibrary.Books.list_books()

    [%PhoenixLibrary.Books.Book{...}, %PhoenixLibrary.Books.Book{...}]
  """
  def list_books do
    Book
    |> Repo.all()
  end

  @doc """
  Retorna uma lista com todos os livros cadastrados no banco de dados cujo
  título corresponde ao termo buscado.

  ## Parâmetros

    - search_term: String que representa o termo a ser buscado.

  ## Exemplos

    iex> PhoenixLibrary.Books.by_title("elixir")

    [%PhoenixLibrary.Books.Book{...}, %PhoenixLibrary.Books.Book{...}]

    iex> PhoenixLibrary.Books.by_title("Pascal")

    []
  """
  def by_title(search_term) do
    wildcard_search = "%#{search_term}%"

    from(book in Book, where: ilike(book.title, ^wildcard_search))
    |> Repo.all()
  end

  @doc """
  Retorna uma lista com todos os livros cadastrados no banco de dados cuja
  autoria corresponde ao termo buscado.

  ## Parâmetros

    - search_term: String que representa o termo a ser buscado.

  ## Exemplos

    iex> PhoenixLibrary.Books.by_authorship("valim")

    [%PhoenixLibrary.Books.Book{...}, %PhoenixLibrary.Books.Book{...}]

    iex> PhoenixLibrary.Books.by_title("Cantú")

    []
  """
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
