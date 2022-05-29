defmodule PhoenixLibrary.Books.BookTest do
  use PhoenixLibrary.DataCase

  alias PhoenixLibrary.Books.Book

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

  describe "update_changeset/2" do
    test "com dados válidos retorna um changeset válido" do
      changeset = Book.update_changeset(%Book{}, @valid_attrs)

      assert changeset.valid?
    end
  end
end
