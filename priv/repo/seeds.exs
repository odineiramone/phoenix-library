# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     PhoenixLibrary.Repo.insert!(%PhoenixLibrary.SomeSchema{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.

alias PhoenixLibrary.Books

Books.create_book(%{
  title: "Clube da Luta",
  publisher: "Editora Leya",
  cover_photo: "https://i.imgur.com/rhy5L2n.png",
  authorship: ["Chuck Palahniuk"]
})

Books.create_book(%{
  title: "Mate-me Por Favor",
  publisher: "LP&M Pocket",
  cover_photo: "https://i.imgur.com/BW0SKWm.png",
  authorship: ["Legs McNeil", "Gillian McCain"]
})

Books.create_book(%{
  title: "O Guia do Mochileiro das Galáxias",
  publisher: "Editora Arqueiro",
  cover_photo: "https://i.imgur.com/0FvAVYu.png",
  authorship: ["Douglas Adamns"]
})

Books.create_book(%{
  title: "O Senhor das Moscas",
  publisher: "Alfaguara",
  cover_photo: "",
  authorship: ["William Golding"]
})

Books.create_book(%{
  title: "O Senhor dos Anéis: A Sociedade do Anel",
  publisher: "Martins Fontes",
  cover_photo: "",
  authorship: ["J. R. R. Tolkien"]
})

Books.create_book(%{
  title: "O Hobbit",
  publisher: "Martins Fontes",
  cover_photo: "",
  authorship: ["J. R. R. Tolkien"]
})

Books.create_book(%{
  title: "1984",
  publisher: "Companhia das Letras",
  cover_photo: "",
  authorship: ["George Orwell"]
})
