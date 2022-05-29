defmodule PhoenixLibrary.BookTest do
  use PhoenixLibrary.DataCase

  alias PhoenixLibrary.Book

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

  describe "validações" do
    test "cover_photo não é obrigatório" do
      changeset = Book.create_changeset(Map.delete(@valid_attrs, :cover_photo))
      assert changeset.valid?
    end

    test "title, publisher e authorship são obrigatórios" do
      changeset = Book.create_changeset(@invalid_attrs)

      assert errors_on(changeset) == %{
               publisher: ["can't be blank"],
               title: ["can't be blank"],
               authorship: ["can't be blank"]
             }
    end

    test "title deve ter pelo menos 4 caracteres" do
      attrs = %{@valid_attrs | title: "abc"}
      changeset = Book.create_changeset(attrs)

      assert errors_on(changeset) == %{title: ["should be at least 4 character(s)"]}
    end

    test "publisher deve ter pelo menos 5 caracteres" do
      attrs = %{@valid_attrs | publisher: "abcd"}
      changeset = Book.create_changeset(attrs)

      assert errors_on(changeset) == %{publisher: ["should be at least 5 character(s)"]}
    end
  end

  describe "create_changeset/1" do
    test "com dados válidos retorna um changeset válido" do
      changeset = Book.create_changeset(@valid_attrs)

      assert changeset.valid?
    end
  end

  describe "changeset_update/2" do
    test "com dados válidos retorna um changeset válido" do
      changeset = Book.changeset_update(%Book{}, @valid_attrs)

      assert changeset.valid?
    end
  end

  describe "create/1" do
    test "com dados válidos cria um livro" do
      assert {:ok, %Book{} = book} = Book.create(@valid_attrs)
      assert book.title == "titulo"
      assert book.publisher == "editora"
      assert book.authorship == ["autoria"]
      assert book.cover_photo == "imagem da capa"
    end

    test "com dados inválidos retorna um changeset de erro" do
      assert {:error, %Ecto.Changeset{}} = Book.create(@invalid_attrs)
    end
  end

  describe "read/1" do
    test "com um id existente retorna um livro" do
      book = insert!(:book)

      assert Book.read(book.id) == {:ok, book}
    end

    test "com um id inexistente retorna erro" do
      assert Book.read("e14c912e-ddeb-11ec-9d64-0242ac120002") == {:error, "Not found!"}
    end
  end

  describe "update/1" do
    test "com um id existente retorna um livro atualizado" do
      book = insert!(:book)

      update_args =
        Map.put(@update_attrs, :id, book.id)
        |> convert_keys_to_string()

      assert {:ok, %Book{} = book} = Book.update(update_args)
      assert book.title == "titulo atualizado"
      assert book.publisher == "editora atualizada"
      assert book.authorship == ["autoria atualizada"]
      assert book.cover_photo == "imagem da capa atualizada"
    end

    test "com um id inexistente retorna erro" do
      assert Book.read("e14c912e-ddeb-11ec-9d64-0242ac120002") == {:error, "Not found!"}
    end
  end

  describe "delete/1" do
    test "com um id existente deleta um livro" do
      book = insert!(:book)

      assert {:ok, _} = Book.delete(book.id)
      assert(Book.read(book.id) == {:error, "Not found!"})
    end

    test "com um id inexistente retorna erro" do
      assert Book.delete("e14c912e-ddeb-11ec-9d64-0242ac120002") == {:error, "Not found!"}
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
      assert Book.delete("e14c912e-ddeb-11ec-9d64-0242ac120002") == {:error, "Not found!"}
    end
  end

  defp convert_keys_to_string(map) do
    map
    |> Map.new(fn {key, value} -> {Atom.to_string(key), value} end)
  end
end
