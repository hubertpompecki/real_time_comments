defmodule SonaComments.Repo.Migrations.CreatePosts do
  use Ecto.Migration

  def change do
    create table(:posts) do
      add :title, :string
      add :slug, :string
      add :text, :text

      timestamps(type: :utc_datetime)
    end

    create unique_index(:posts, [:slug])
  end
end
