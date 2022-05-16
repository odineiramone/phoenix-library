defmodule PhoenixLibrary.Book do
  use Ecto.Schema
  import Ecto.Changeset

  alias PhoenixLibrary.Repo

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
    |> validate_length(:title, min: 5)
    |> validate_length(:publisher, min: 5)
  end

  def changeset_create(params), do: changeset(%__MODULE__{}, params)
  def changeset_update(source, params), do: changeset(source, params)

  def create(params) do
    changeset_create(params)
    |> Repo.insert()
  end

  def read(uuid) do
    __MODULE__
    |> Repo.get(uuid)
  end

  def update(%{"id" => id} = params) do
    read(id)
    |> changeset_update(params)
    |> Repo.update()
  end

  def delete(id) do
    read(id)
    |> Repo.delete()
  end

  def all do
    __MODULE__
    |> Repo.all()
  end
end
