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
    |> validate_length(:title, min: 4)
    |> validate_length(:publisher, min: 5)
  end

  def create_changeset(params), do: changeset(%__MODULE__{}, params)
  def update_changeset(source, params), do: changeset(source, params)
end
