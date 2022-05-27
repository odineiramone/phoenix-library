defmodule PhoenixLibraryWeb.SearchController do
  use PhoenixLibraryWeb, :controller

  alias PhoenixLibrary.Search

  action_fallback PhoenixLibraryWeb.FallbackController

  def index(conn, params) do
    with {:ok, books} <- Search.call(params) do
      render(conn, "index.json", books: books)
    end
  end
end
