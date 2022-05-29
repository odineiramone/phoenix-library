defmodule PhoenixLibrary.Search do
  import Ecto.Query, only: [from: 2]

  alias PhoenixLibrary.{Books.Book, Repo}

  def call(%{"title" => search_term}), do: {:ok, by_title(search_term)}

  def call(%{"authorship" => search_term}), do: {:ok, by_authorship(search_term)}

  def call(%{}), do: {:error, "No search parameters!"}

  defp by_title(search_term) do
    wildcard_search = "%#{search_term}%"

    from(book in Book, where: ilike(book.title, ^wildcard_search))
    |> Repo.all()
  end

  defp by_authorship(search_term) do
    wildcard_search = "%#{search_term}%"

    from(book in Book,
      where: ilike(fragment("ARRAY_TO_STRING(?, ',')", book.authorship), ^wildcard_search)
    )
    |> Repo.all()
  end
end
