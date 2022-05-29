defmodule PhoenixLibrary.SearchTest do
  use PhoenixLibrary.DataCase

  alias PhoenixLibrary.Search

  describe "call/1" do
    test "com parâmetros de autoria, retorna uma lista" do
      assert {:ok, []} = Search.call(%{"authorship" => "teste"})
    end

    test "com parâmetros de título, retorna uma lista" do
      assert {:ok, []} = Search.call(%{"title" => "teste"})
    end

    test "com parâmetros inválidos, retorna um erro" do
      assert {:error, "No search parameters!"} = Search.call(%{"teste" => "teste"})
    end
  end
end
