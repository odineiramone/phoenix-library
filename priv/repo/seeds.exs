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

alias PhoenixLibrary.Book

Book.create(%{
  title: "Clube da Luta",
  publisher: "Editora Leya",
  cover_photo: "https://i.imgur.com/rhy5L2n.png",
  authorship: ["Chuck Palahniuk"]
})

Book.create(%{
  title: "Mate-me Por Favor",
  publisher: "LP&M Pocket",
  cover_photo: "https://i.imgur.com/BW0SKWm.png",
  authorship: ["Legs McNeil", "Gillian McCain"]
})

Book.create(%{
  title: "O Guia do Mochileiro das Galáxias",
  publisher: "Editora Arqueiro",
  cover_photo: "https://i.imgur.com/0FvAVYu.png",
  authorship: ["Douglas Adamns"]
})

Book.create(%{
  title: "O Senhor das Moscas",
  publisher: "Alfaguara",
  cover_photo: "",
  authorship: ["William Golding"]
})

Book.create(%{
  title: "O Senhor dos Anéis: A Sociedade do Anel",
  publisher: "Martins Fontes",
  cover_photo: "",
  authorship: ["J. R. R. Tolkien"]
})

Book.create(%{
  title: "O Hobbit",
  publisher: "Martins Fontes",
  cover_photo: "",
  authorship: ["J. R. R. Tolkien"]
})

Book.create(%{
  title: "1984",
  publisher: "Companhia das Letras",
  cover_photo: "",
  authorship: ["George Orwell"]
})
