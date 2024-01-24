defmodule SonaComments.Content.Post do
  use Ecto.Schema
  import Ecto.Changeset

  schema "posts" do
    field :title, :string
    field :text, :string
    field :slug, :string

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(post, attrs) do
    post
    |> cast(attrs, [:title, :slug, :text])
    |> validate_required([:title, :slug, :text])
    |> unique_constraint(:slug)
  end
end
