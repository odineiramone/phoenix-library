defmodule PhoenixLibrary.Factory do
  alias PhoenixLibrary.Repo

  def build(:book) do
    %PhoenixLibrary.Book{
      title: "Viva La Vida Tosca",
      publisher: "Darkside",
      cover_photo: "https://i.imgur.com/ld0PA1c.png",
      authorship: ["João Gordo"]
    }
  end

  def build(factory_name, attributes) do
    factory_name
    |> build()
    |> struct!(attributes)
  end

  def insert!(factory_name, attributes \\ []) do
    factory_name
    |> build(attributes)
    |> Repo.insert!()
  end
end
