defmodule SonaComments.Content.Post do
  use Ecto.Schema
  import Ecto.Changeset

  alias SonaComments.Content.Comment

  schema "posts" do
    field :title, :string
    field :text, :string
    field :slug, :string
    has_many :comments, Comment

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
