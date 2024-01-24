defmodule SonaComments.Content do
  @moduledoc """
  The Content context.
  """

  import Ecto.Query, warn: false
  alias SonaComments.Repo

  alias SonaComments.Content.{Comment, Post}

  @doc """
  Returns the list of posts.

  ## Examples

      iex> list_posts()
      [%Post{}, ...]

  """
  def list_posts do
    Repo.all(Post)
  end

  @doc """
  Gets a single post by it's slug.

  Raises `Ecto.NoResultsError` if the Post does not exist.

  ## Examples

      iex> get_post_by_slug!("some-slug")
      %Post{}

      iex> get_post!("bad-slug")
      ** (Ecto.NoResultsError)

  """
  def get_post_by_slug!(slug) do
    comments_query = from c in Comment, order_by: [desc: c.inserted_at]
    Repo.one!(from p in Post, where: p.slug == ^slug, preload: [comments: ^comments_query])
  end

  @doc """
  Creates a post.

  ## Examples

      iex> create_post(%{field: value})
      {:ok, %Post{}}

      iex> create_post(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_post(attrs \\ %{}) do
    %Post{}
    |> Post.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Creates a comment.

  ## Examples

      iex> create_post(%{field: value})
      {:ok, %Post{}}

      iex> create_post(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_comment(%Post{} = post, attrs \\ %{}) do
    attrs = Map.put(attrs, "post_id", post.id)

    %Comment{}
    |> Comment.changeset(attrs)
    |> dbg()
    |> Repo.insert()
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking post changes.

  ## Examples

      iex> change_post(post)
      %Ecto.Changeset{data: %Post{}}

  """
  def change_post(%Post{} = post, attrs \\ %{}) do
    Post.changeset(post, attrs)
  end
end
