defmodule PhoenixLibrary.BooksTest do
  use PhoenixLibrary.DataCase

  alias PhoenixLibrary.{Books, Books.Book}

  import PhoenixLibrary.Factory

  @valid_attrs %{
    title: "titulo",
    publisher: "editora",
    authorship: ["autoria"],
    cover_photo: "imagem da capa"
  }

  @update_attrs %{
    title: "titulo atualizado",
    publisher: "editora atualizada",
    authorship: ["autoria atualizada"],
    cover_photo: "imagem da capa atualizada"
  }

  @invalid_attrs %{title: nil, publisher: nil, authorship: nil, cover_photo: nil}

  describe "create_book/1" do
    test "com dados válidos cria um livro" do
      assert {:ok, %Book{} = book} = Books.create_book(@valid_attrs)
      assert book.title == "titulo"
      assert book.publisher == "editora"
      assert book.authorship == ["autoria"]
      assert book.cover_photo == "imagem da capa"
    end

    test "com dados inválidos retorna um changeset de erro" do
      assert {:error, %Ecto.Changeset{}} = Books.create_book(@invalid_attrs)
    end
  end

  describe "find_book/1" do
    test "com um id existente retorna um livro" do
      book = insert!(:book)

      assert Books.find_book(book.id) == {:ok, book}
    end

    test "com um id inexistente retorna erro" do
      assert Books.find_book("e14c912e-ddeb-11ec-9d64-0242ac120002") == {:error, :not_found}
    end
  end

  describe "update_book/1" do
    test "com um id existente retorna um livro atualizado" do
      book = insert!(:book)

      update_args =
        Map.put(@update_attrs, :id, book.id)
        |> convert_keys_to_string()

      assert {:ok, %Book{} = book} = Books.update_book(update_args)
      assert book.title == "titulo atualizado"
      assert book.publisher == "editora atualizada"
      assert book.authorship == ["autoria atualizada"]
      assert book.cover_photo == "imagem da capa atualizada"
    end

    test "com um id inexistente retorna erro" do
      update_args =
        Map.put(@update_attrs, :id, "e14c912e-ddeb-11ec-9d64-0242ac120002")
        |> convert_keys_to_string()

      assert Books.update_book(update_args) == {:error, :not_found}
    end
  end

  describe "delete_book/1" do
    test "com um id existente deleta um livro" do
      book = insert!(:book)

      assert {:ok, _} = Books.delete_book(book.id)
      assert(Books.find_book(book.id) == {:error, :not_found})
    end

    test "com um id inexistente retorna erro" do
      assert Books.delete_book("e14c912e-ddeb-11ec-9d64-0242ac120002") == {:error, :not_found}
    end
  end

  describe "list_books/0" do
    test "retorna todos os livros cadastrados" do
      book = insert!(:book)

      _expected_response = [
        %Book{
          authorship: book.authorship,
          cover_photo: book.cover_photo,
          id: book.id,
          inserted_at: book.inserted_at,
          publisher: book.publisher,
          title: book.title,
          updated_at: book.updated_at
        }
      ]

      assert match?(_expected_response, Books.list_books())
    end
  end

  describe "by_title/1" do
    setup do
      insert_books()
    end

    test "retorna lista com livros encontrados na busca por título", %{
      book_1: _,
      book_2: book_2,
      book_3: book_3
    } do
      assert Books.by_title("senhor") == [book_2, book_3]
    end
  end

  describe "by_authorship/1" do
    setup do
      insert_books()
    end

    test "retorna lista com livros encontrados na busca por autoria", %{
      book_1: book_1,
      book_2: book_2,
      book_3: _
    } do
      assert Books.by_authorship("tolkien") == [book_1, book_2]
    end
  end

  def insert_books do
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

    %{book_1: book_1, book_2: book_2, book_3: book_3}
  end

  defp convert_keys_to_string(map) do
    map
    |> Map.new(fn {key, value} -> {Atom.to_string(key), value} end)
  end
end
