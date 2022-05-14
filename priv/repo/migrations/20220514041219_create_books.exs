defmodule PhoenixLibrary.Repo.Migrations.CreateBooks do
  use Ecto.Migration

  def change do
    create table(:books, primary_key: false) do
      add :id, :uuid, primary_key: true
      add :title, :string, null: false
      add :publisher, :string, null: false
      add :cover_photo, :string
      add :authorship, {:array, :string}, null: false

      timestamps()
    end
  end
end
