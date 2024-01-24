defmodule SonaComments.ContentFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `SonaComments.Content` context.
  """

  @doc """
  Generate a unique post slug.
  """
  def unique_post_slug, do: "some-slug#{System.unique_integer([:positive])}"

  @doc """
  Generate a post.
  """
  def post_fixture(attrs \\ %{}) do
    {:ok, post} =
      attrs
      |> Enum.into(%{
        slug: unique_post_slug(),
        text: "some text",
        title: "some title"
      })
      |> SonaComments.Content.create_post()

    post
  end
end
