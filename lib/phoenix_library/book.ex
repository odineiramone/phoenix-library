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
    |> validate_length(:title, min: 4)
    |> validate_length(:publisher, min: 5)
  end

  def create_changeset(params), do: changeset(%__MODULE__{}, params)
  def update_changeset(source, params), do: changeset(source, params)

  def create(params) do
    create_changeset(params)
    |> Repo.insert()
  end

  def read(uuid) do
    case Repo.get(__MODULE__, uuid) do
      nil -> {:error, "Not found!"}
      data -> {:ok, data}
    end
  end

  def update(%{"id" => id} = params) do
    case read(id) do
      {:error, "Not found!"} -> {:error, "Not found!"}
      {:ok, entity} -> update_entity(entity, params)
    end
  end

  def delete(id) do
    case read(id) do
      {:error, "Not found!"} -> {:error, "Not found!"}
      {:ok, book} -> Repo.delete(book)
    end
  end

  def all do
    __MODULE__
    |> Repo.all()
  end

  defp update_entity(entity, params) do
    entity
    |> update_changeset(params)
    |> Repo.update()
  end
end
