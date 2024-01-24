defmodule SonaComments.Repo.Migrations.CreateComments do
  use Ecto.Migration

  def change do
    create table(:comments) do
      add :author, :string
      add :text, :text
      add :post_id, references(:posts, on_delete: :delete_all)

      timestamps(type: :utc_datetime)
    end

    create index(:comments, [:post_id])
  end
end
