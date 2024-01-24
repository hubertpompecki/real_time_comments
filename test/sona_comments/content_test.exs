defmodule SonaComments.ContentTest do
  use SonaComments.DataCase

  alias SonaComments.Content

  describe "posts" do
    alias SonaComments.Content.Post

    import SonaComments.ContentFixtures

    @invalid_attrs %{title: nil, text: nil, slug: nil}

    test "list_posts/0 returns all posts" do
      post = post_fixture()
      assert Content.list_posts() == [post]
    end

    test "get_post_by_slug!/1 returns the post with given slug" do
      post = post_fixture()
      assert Content.get_post!(post.slug) == post
    end

    test "create_post/1 with valid data creates a post" do
      valid_attrs = %{title: "some title", text: "some text", slug: "some slug"}

      assert {:ok, %Post{} = post} = Content.create_post(valid_attrs)
      assert post.title == "some title"
      assert post.text == "some text"
      assert post.slug == "some slug"
    end

    test "create_post/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Content.create_post(@invalid_attrs)
    end
  end
end
