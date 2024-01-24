defmodule SonaCommentsWeb.PostLive.Show do
  use SonaCommentsWeb, :live_view

  alias SonaComments.Content
  alias SonaComments.Content.{Comment, Post}

  import SonaCommentsWeb.Comment

  @impl true
  def mount(_params, _session, socket) do
    {:ok, socket}
  end

  @impl true
  def handle_params(%{"slug" => slug}, _, socket) do
    post = Content.get_post_by_slug!(slug)

    {:noreply,
     socket
     |> assign(:page_title, post.title)
     |> assign(:post, post)
     |> assign(:new_post, Post.changeset(%Post{}, %{}))}
  end

  @impl true
  def handle_event("new_post", %{"post" => %{"author" => author, "text" => text} = args}, socket) do
    case dbg(Content.create_comment(socket.assigns.post, args)) do
      {:ok, comment} ->
        post = socket.assigns.post
        post = %{post | comments: [comment | post.comments]}
        {:noreply, assign(socket, :post, post)}

      {:error, reason} ->
        {:noreply, 
        socket
        |> put_flash(:error, "Comment couldn't be created: #{inspect(reason)}")}
    end
  end
end
