defmodule PhoenixLibrary.Search do
  alias PhoenixLibrary.Books

  # fazer teste checando se o retorno é um {:ok, lista de Book}
  def call(%{"title" => search_term}), do: {:ok, Books.by_title(search_term)}

  def call(%{"authorship" => search_term}), do: {:ok, Books.by_authorship(search_term)}

  def call(%{}), do: {:error, "No search parameters!"}
end
