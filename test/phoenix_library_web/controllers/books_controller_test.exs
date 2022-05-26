defmodule PhoenixLibraryWeb.BooksControllerTest do
  use PhoenixLibraryWeb.ConnCase

  import PhoenixLibrary.Factory

  describe "GET /api/books" do
    test "retorna lista com todos os livros", %{conn: conn} do
      book = insert!(:book)

      conn = get(conn, Routes.books_path(conn, :index))

      expected_response = %{
        "books" => [
          %{
            "authorship" => book.authorship,
            "cover_photo" => book.cover_photo,
            "id" => book.id,
            "publisher" => book.publisher,
            "title" => book.title
          }
        ]
      }

      assert match?(_expected_response, json_response(conn, 200)["data"])
    end
  end

  describe "GET /api/books/:id" do
    test "retorna um livro existente", %{conn: conn} do
      book = insert!(:book)

      conn = get(conn, Routes.books_path(conn, :show, book.id))

      expected_response = %{
        "book" => %{
          "authorship" => book.authorship,
          "cover_photo" => book.cover_photo,
          "id" => book.id,
          "publisher" => book.publisher,
          "title" => book.title
        }
      }

      assert match?(_expected_response, json_response(conn, 200)["data"]["data"])
    end

    test "retorna mensagem de não encotrado caso o livro não exista", %{conn: conn} do
      conn = get(conn, Routes.books_path(conn, :show, "9085b9df-a383-4a8c-b0af-b93fbc831277"))

      assert json_response(conn, 404) == %{"message" => "Not found!", "status" => "error"}
    end
  end

  describe "POST /api/books" do
    test "retorna livro criado", %{conn: conn} do
      book_params = %{
        "title" => "Viva La Vida Tosca",
        "publisher" => "Darkside",
        "cover_photo" => "https://i.imgur.com/ld0PA1c.png",
        "authorship" => ["João Gordo"]
      }

      _expected_response = %{"book" => book_params}

      conn = post(conn, Routes.books_path(conn, :create), book_params)

      assert match?(_expected_response, json_response(conn, 200)["data"])
    end

    test "retorna mensagem com erros de validação caso o livro não possa ser criado", %{
      conn: conn
    } do
      expected_response = %{
        "message" => %{
          "authorship" => ["can't be blank"],
          "publisher" => ["can't be blank"],
          "title" => ["can't be blank"]
        },
        "status" => "error"
      }

      conn = post(conn, Routes.books_path(conn, :create), %{})

      assert json_response(conn, 400) == expected_response
    end
  end

  describe "DELETE /api/books/:id" do
    test "retorna mensagem de livro deletado", %{conn: conn} do
      book = insert!(:book)
      expected_response = %{"message" => "Book deleted!"}

      conn = delete(conn, Routes.books_path(conn, :delete, book.id))

      assert json_response(conn, 200)["data"] == expected_response
    end

    test "retorna mensagem de livro não encontrado caso o livro não exista", %{conn: conn} do
      book_id = "92a2fa73-5d1c-43a9-8ce0-c9de143be0d5"
      expected_response = %{"message" => "Not found!", "status" => "error"}

      conn = delete(conn, Routes.books_path(conn, :delete, book_id))

      assert json_response(conn, 404) == expected_response
    end
  end

  describe "PATCH /api/books/:id" do
    test "retorna livro alterado", %{conn: conn} do
      book = insert!(:book)

      book_params = %{
        "title" => "João Gordo: Viva La Vida Louca"
      }

      _expected_response = %{
        "book" => %{
          "authorship" => book.authorship,
          "cover_photo" => book.cover_photo,
          "id" => book.id,
          "publisher" => book.publisher,
          "title" => "João Gordo: Viva La Vida Louca"
        }
      }

      conn = patch(conn, Routes.books_path(conn, :delete, book.id), book_params)

      assert match?(_expected_response, json_response(conn, 200)["data"])
    end

    test "retorna mensagem com erros de validação caso o livro não possa ser alterado", %{
      conn: conn
    } do
      book = insert!(:book)

      book_params = %{"title" => ""}
      expected_response = %{"message" => %{"title" => ["can't be blank"]}, "status" => "error"}

      conn = patch(conn, Routes.books_path(conn, :delete, book.id), book_params)

      assert json_response(conn, 400) == expected_response
    end

    test "retorna mensagem de livro não encontrado caso o livro não exista", %{conn: conn} do
      book_id = "92a2fa73-5d1c-43a9-8ce0-c9de143be0d5"

      book_params = %{
        "title" => "João Gordo: Viva La Vida Tosca"
      }

      expected_response = %{"message" => "Not found!", "status" => "error"}

      conn = patch(conn, Routes.books_path(conn, :delete, book_id), book_params)

      assert json_response(conn, 404) == expected_response
    end
  end
end
