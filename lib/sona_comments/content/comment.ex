defmodule SonaComments.Content.Comment do
  use Ecto.Schema
  import Ecto.Changeset

  alias SonaComments.Content.Post

  schema "comments" do
    field :author, :string
    field :text, :string
    belongs_to :post, Post

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(comment, attrs) do
    comment
    |> cast(attrs, [:author, :text])
    |> validate_required([:author, :text])
  end
end
