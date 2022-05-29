defmodule PhoenixLibrary.Books.Book do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, Ecto.UUID, autogenerate: true}

  schema "books" do
    field :title, :string
    field :publisher, :string
    field :cover_photo, :string
    field :authorship, {:array, :string}

    timestamps()
  end

  defp changeset(source, params) do
    source
    |> cast(params, [:title, :publisher, :cover_photo, :authorship])
    |> validate_required([:title, :publisher, :authorship])
    |> validate_length(:title, min: 4)
    |> validate_length(:publisher, min: 5)
  end

  def create_changeset(params), do: changeset(%__MODULE__{}, params)
  def update_changeset(source, params), do: changeset(source, params)
end
