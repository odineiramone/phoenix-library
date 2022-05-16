defmodule PhoenixLibraryWeb.BooksControllerTest do
  use PhoenixLibraryWeb.ConnCase

  import PhoenixLibrary.Factory

  describe "index" do
    test "lista todos os cursos", %{conn: conn} do
      book = insert!(:book)

      conn = get(conn, Routes.books_path(conn, :index))
      
      expected_response = %{                                                                     
        "books" => [                                                                          
          %{                                                                                 
            "authorship" => book.authorship,
            "cover_photo" => book.cover_photo,
            "id" => book.id,
            "inserted_at" => NaiveDateTime.to_iso8601(book.inserted_at),
            "publisher" => book.publisher,
            "title" => book.title,
            "updated_at" => NaiveDateTime.to_iso8601(book.updated_at)
          }                            
        ]                                                                                 
      }

      assert json_response(conn, 200)["data"] == expected_response
    end
  end

  describe "show" do
    test "lista um curso", %{conn: conn} do
      book = insert!(:book)

      conn = get(conn, Routes.books_path(conn, :show, book.id))

      expected_response = %{
        "book" => %{
          "authorship" => book.authorship,
          "cover_photo" => book.cover_photo,
          "id" => book.id,
          "inserted_at" => NaiveDateTime.to_iso8601(book.inserted_at),
          "publisher" => book.publisher,
          "title" => book.title,
          "updated_at" => NaiveDateTime.to_iso8601(book.updated_at)
        }
      }

      assert json_response(conn, 200)["data"] == expected_response
    end
  end

  describe "create" do
    test "lista curso criado", %{conn: conn} do
      book_params = %{
        "title"=> "Viva La Vida Tosca",
        "publisher"=> "Darkside",
        "cover_photo"=> "https://i.imgur.com/ld0PA1c.png",
        "authorship"=> ["João Gordo"]
      }

      conn = post(conn, Routes.books_path(conn, :create), book_params)

      assert %{"book" => book_params} = json_response(conn, 200)["data"]
    end
  end

  describe "delete" do
    test "mostra mensagem de curso deletado", %{conn: conn} do
      book = insert!(:book)

      conn = delete(conn, Routes.books_path(conn, :delete, book.id))

      assert json_response(conn, 200)["data"] == %{"message" => "Book deleted!"}
    end
  end

  describe "update" do
    test "lista curso alterado", %{conn: conn} do
      book = insert!(:book)

      book_params = %{
        "title"=> "João Gordo: Viva La Vida Tosca"
      }

      conn = patch(conn, Routes.books_path(conn, :delete, book.id), book_params)

      assert %{"book" => book_params} = json_response(conn, 200)["data"]
    end
  end
end
