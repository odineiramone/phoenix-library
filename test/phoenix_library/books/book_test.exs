defmodule PhoenixLibrary.Books.BookTest do
  use PhoenixLibrary.DataCase

  alias PhoenixLibrary.Books.Book

  @valid_attrs %{
    title: "titulo",
    publisher: "editora",
    authorship: ["autoria"],
    cover_photo: "imagem da capa"
  }

  @invalid_attrs %{title: nil, publisher: nil, authorship: nil, cover_photo: nil}

  @text_with_256_chars "Lorem ipsum dolor sit amet, consectetur adipiscing elit.
    Donec vitae vestibulum nisl, at varius libero. Etiam cursus varius est ut tempus.
    Quisque vitae suscipit tortor. Phasellus neque nisl, sagittis sed sem eget, venenatis
    ullamcorper odio. Mauris iacul."

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

    test "title deve ter até 255 caracteres" do
      attrs = %{@valid_attrs | title: @text_with_256_chars}
      changeset = Book.create_changeset(attrs)

      assert errors_on(changeset) == %{title: ["should be at most 255 character(s)"]}
    end

    test "publisher deve ter pelo menos 5 caracteres" do
      attrs = %{@valid_attrs | publisher: "abcd"}
      changeset = Book.create_changeset(attrs)

      assert errors_on(changeset) == %{publisher: ["should be at least 5 character(s)"]}
    end

    test "publisher deve ter até 255 caracteres" do
      attrs = %{@valid_attrs | publisher: @text_with_256_chars}
      changeset = Book.create_changeset(attrs)

      assert errors_on(changeset) == %{publisher: ["should be at most 255 character(s)"]}
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
