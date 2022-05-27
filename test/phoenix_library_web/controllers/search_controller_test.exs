defmodule PhoenixLibraryWeb.SearchControllerTest do
  use PhoenixLibraryWeb.ConnCase

  import PhoenixLibrary.Factory

  describe "GET /api/search?title=senhor" do
    setup :insert_books

    test "retorna lista com livros encontrados na busca por título", %{
      conn: conn,
      book_1: _,
      book_2: book_2,
      book_3: book_3
    } do
      _expected_response = %{
        "books" => [
          %{
            "authorship" => book_2.authorship,
            "cover_photo" => book_2.cover_photo,
            "id" => book_2.id,
            "publisher" => book_2.publisher,
            "title" => book_2.title
          },
          %{
            "authorship" => book_3.authorship,
            "cover_photo" => book_3.cover_photo,
            "id" => book_3.id,
            "publisher" => book_3.publisher,
            "title" => book_3.title
          }
        ],
        "status" => "success"
      }

      conn = get(conn, Routes.search_path(conn, :index, title: "senhor"))

      assert match?(_expected_response, json_response(conn, 200)["data"])
    end
  end

  describe "GET /api/search?authorship=tolkien" do
    setup :insert_books

    test "retorna lista com livros encontrados na busca por autoria", %{
      conn: conn,
      book_1: book_1,
      book_2: book_2,
      book_3: _
    } do
      _expected_response = %{
        "books" => [
          %{
            "authorship" => book_2.authorship,
            "cover_photo" => book_2.cover_photo,
            "id" => book_2.id,
            "publisher" => book_2.publisher,
            "title" => book_2.title
          },
          %{
            "authorship" => book_1.authorship,
            "cover_photo" => book_1.cover_photo,
            "id" => book_1.id,
            "publisher" => book_1.publisher,
            "title" => book_1.title
          }
        ],
        "status" => "success"
      }

      conn = get(conn, Routes.search_path(conn, :index, title: "senhor"))

      assert match?(_expected_response, json_response(conn, 200)["data"])
    end
  end

  describe "GET /api/search?pages=6" do
    test "retorna mensagem de falha na busca por campos inexistentes", %{conn: conn} do
      _expected_response = %{"data" => %{"book" => "No search parameters!"}, "status" => "fail"}

      conn = get(conn, Routes.search_path(conn, :index, pages: 6))

      assert match?(_expected_response, json_response(conn, 404))
    end
  end

  describe "GET /api/search" do
    test "retorna mensagem de falha na busca vazia", %{conn: conn} do
      _expected_response = %{"data" => %{"book" => "No search parameters!"}, "status" => "fail"}

      conn = get(conn, Routes.search_path(conn, :index, pages: 6))

      assert match?(_expected_response, json_response(conn, 404))
    end
  end

  describe "GET /api/search?title=crianças" do
    setup :insert_books

    test "retorna lista de livros vazia na busca com termos inexistentes na base de dados", %{
      conn: conn
    } do
      _expected_response = %{"books" => [], "status" => "success"}

      conn = get(conn, Routes.search_path(conn, :index, title: "senhor"))

      assert match?(_expected_response, json_response(conn, 200)["data"])
    end
  end

  def insert_books(%{conn: conn}) do
    book_1 =
      insert!(:book,
        title: "O Hobbit",
        publisher: "Martins Fontes",
        cover_photo: "",
        authorship: ["J. R. R. Tolkien"]
      )

    book_2 =
      insert!(:book,
        title: "O Senhor dos Anéis: A Sociedade do Anel",
        publisher: "Martins Fontes",
        cover_photo: "",
        authorship: ["J. R. R. Tolkien"]
      )

    book_3 =
      insert!(:book,
        title: "O Senhor das Moscas",
        publisher: "Alfaguara",
        cover_photo: "",
        authorship: ["William Golding"]
      )

    %{conn: conn, book_1: book_1, book_2: book_2, book_3: book_3}
  end
end
