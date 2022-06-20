defmodule PhoenixLibrary.Search do
  @moduledoc """
  Fornece a função `call/1` para pesquisar livros por título ou autoria.
  """

  alias PhoenixLibrary.Books

  @doc """
  Retorna um chageset para criar um novo registro no banco de dados. Atualmente suporta
  apenas busca por título (title) e autoria (authorship).

  ## Parâmetros

    - search_term: String que representa o termo a ser buscado.

  ## Exemplos

    iex> PhoenixLibrary.Search.call(%{"title" => "elixir"})

    {:ok, [%PhoenixLibrary.Books.Book{...}, %PhoenixLibrary.Books.Book{...}]}

    iex> PhoenixLibrary.Search.call(%{"authorship" => "valim"})

    {:ok, [%PhoenixLibrary.Books.Book{...}, %PhoenixLibrary.Books.Book{...}]}

    iex> PhoenixLibrary.Search.call(%{"publisher" => "O'Reilly Media"})

    {:error, :not_found}

    iex> PhoenixLibrary.Search.call(%{})    
    
    {:error, :not_found}
  """
  def call(%{"title" => search_term}), do: {:ok, Books.by_title(search_term)}
  def call(%{"authorship" => search_term}), do: {:ok, Books.by_authorship(search_term)}
  def call(%{}), do: {:error, :not_found}
end
