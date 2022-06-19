defmodule PhoenixLibrary.Search do
  @moduledoc """
  Fornece a função `call/1` para pesquisar livros por título ou autoria.
  """

  alias PhoenixLibrary.Books

  # fazer teste checando se o retorno é um {:ok, lista de Book}
  def call(%{"title" => search_term}), do: {:ok, Books.by_title(search_term)}

  def call(%{"authorship" => search_term}), do: {:ok, Books.by_authorship(search_term)}

  def call(%{}), do: {:error, :not_found}
end
