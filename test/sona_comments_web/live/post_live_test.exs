defmodule SonaCommentsWeb.PostLiveTest do
  use SonaCommentsWeb.ConnCase

  import Phoenix.LiveViewTest
  import SonaComments.ContentFixtures

  @create_attrs %{title: "some title", text: "some text", slug: "some slug"}
  @update_attrs %{
    title: "some updated title",
    text: "some updated text",
    slug: "some updated slug"
  }
  @invalid_attrs %{title: nil, text: nil, slug: nil}

  defp create_post(_) do
    post = post_fixture()
    %{post: post}
  end

  describe "Index" do
    setup [:create_post]

    test "lists all posts", %{conn: conn, post: post} do
      {:ok, _index_live, html} = live(conn, ~p"/posts")

      assert html =~ "Listing Posts"
      assert html =~ post.title
    end
  end

  describe "Show" do
    setup [:create_post]

    test "displays post", %{conn: conn, post: post} do
      {:ok, _show_live, html} = live(conn, ~p"/posts/#{post.slug}")

      assert html =~ post.title
      assert html =~ post.text
    end

    test "publishes a new a comment", %{conn: conn, post: post} do
      {:ok, show_live, html} = live(conn, ~p"/posts/#{post.slug}")
      Phoenix.PubSub.subscribe(SonaComments.PubSub, post.slug)

      assert show_live
             |> form("#new_comment_form",
               comment: %{text: "This is the text of the comment", author: "Alice"}
             )
             |> render_submit()

      assert_receive({:new_comment, comment})

      send(show_live.pid, {:new_comment, comment})
      assert render(show_live) =~ "This is the text of the comment"
    end
  end
end
