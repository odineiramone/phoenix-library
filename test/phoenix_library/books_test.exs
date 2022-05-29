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

  describe "create/1" do
    test "com dados válidos cria um livro" do
      assert {:ok, %Book{} = book} = Books.create(@valid_attrs)
      assert book.title == "titulo"
      assert book.publisher == "editora"
      assert book.authorship == ["autoria"]
      assert book.cover_photo == "imagem da capa"
    end

    test "com dados inválidos retorna um changeset de erro" do
      assert {:error, %Ecto.Changeset{}} = Books.create(@invalid_attrs)
    end
  end

  describe "read/1" do
    test "com um id existente retorna um livro" do
      book = insert!(:book)

      assert Books.read(book.id) == {:ok, book}
    end

    test "com um id inexistente retorna erro" do
      assert Books.read("e14c912e-ddeb-11ec-9d64-0242ac120002") == {:error, "Not found!"}
    end
  end

  describe "update/1" do
    test "com um id existente retorna um livro atualizado" do
      book = insert!(:book)

      update_args =
        Map.put(@update_attrs, :id, book.id)
        |> convert_keys_to_string()

      assert {:ok, %Book{} = book} = Books.update(update_args)
      assert book.title == "titulo atualizado"
      assert book.publisher == "editora atualizada"
      assert book.authorship == ["autoria atualizada"]
      assert book.cover_photo == "imagem da capa atualizada"
    end

    test "com um id inexistente retorna erro" do
      assert Books.read("e14c912e-ddeb-11ec-9d64-0242ac120002") == {:error, "Not found!"}
    end
  end

  describe "delete/1" do
    test "com um id existente deleta um livro" do
      book = insert!(:book)

      assert {:ok, _} = Books.delete(book.id)
      assert(Books.read(book.id) == {:error, "Not found!"})
    end

    test "com um id inexistente retorna erro" do
      assert Books.delete("e14c912e-ddeb-11ec-9d64-0242ac120002") == {:error, "Not found!"}
    end
  end

  describe "all/0" do
    test "retorna todos os livros cadastrados" do
      book = insert!(:book)

      _expected_response = [
        %Book{
          authorship: ["João Gordo"],
          cover_photo: "https://i.imgur.com/ld0PA1c.png",
          id: "1076be51-445d-4199-9604-c82a3d06e0ba",
          inserted_at: ~N[2022-05-27 18:56:06],
          publisher: "Darkside",
          title: "Viva La Vida Tosca",
          updated_at: ~N[2022-05-27 18:56:06]
        }
      ]

      assert match?(_expected_response, book)
    end

    test "com um id inexistente retorna erro" do
      assert Books.delete("e14c912e-ddeb-11ec-9d64-0242ac120002") == {:error, "Not found!"}
    end
  end

  defp convert_keys_to_string(map) do
    map
    |> Map.new(fn {key, value} -> {Atom.to_string(key), value} end)
  end
end
