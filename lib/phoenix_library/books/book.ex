defmodule PhoenixLibrary.Books.Book do
  @moduledoc """
  Fornece a função `create_changeset/1` para criar um novo registro no banco
  de dados e fornece a função `update_changeset/2` para atualizar um registro
  existente no banco de dados.
  """

  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, Ecto.UUID, autogenerate: true}

  @optional_fields ~w(cover_photo)a
  @required_fields ~w(title publisher authorship)a
  @castable_fields @optional_fields ++ @required_fields

  schema "books" do
    field :title, :string
    field :publisher, :string
    field :cover_photo, :string
    field :authorship, {:array, :string}

    timestamps()
  end

  defp changeset(source, params) do
    source
    |> cast(params, @castable_fields)
    |> validate_required(@required_fields)
    |> validate_length(:title, min: 4, max: 255)
    |> validate_length(:publisher, min: 5, max: 255)
  end

  @doc """
  Retorna um chageset para criar um novo registro no banco de dados

  ## Parâmetros

    - params: Map que representa os dados para criar um novo livro.

  ## Exemplos

  ```elixir
  iex> PhoenixLibrary.Books.Book.create_changeset(%{
         title: "Adopting Elixir",
         publisher: "The Pragmatic Programmers",
         authorship: ["Ben Marx", "José Valim", "Bruce Tate"],
         cover_photo: "https://pragprog.com/titles/tvmelixir/adopting-elixir/tvmelixir.jpg"
       })
  #Ecto.Changeset<...>
  ```
  """
  def create_changeset(params), do: changeset(%__MODULE__{}, params)

  @doc """
  Retorna um changeset para atualizar um registro já existente no banco de dados

  ## Parâmetros

    - source: Struct que representa um livro já existente no banco de dados.
    - params: Map que representa os dados para atualizar um livro.

  ## Exemplos

  ```elixir
  iex> PhoenixLibrary.Books.Book.update_changeset(
        %PhoenixLibrary.Books.Book{...},
        %{title: "Adopting Elixir - From Concept to Production"}
       )
  #Ecto.Changeset<...>
  ```
  """
  def update_changeset(source, params), do: changeset(source, params)
end
