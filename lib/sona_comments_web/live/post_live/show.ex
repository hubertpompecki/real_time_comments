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
     |> assign(:new_comment, Comment.changeset(%Comment{}, %{}))}
  end

  @impl true
  def handle_event("new_comment", %{"comment" => %{"author" => author, "text" => text} = args}, socket) do
    case Content.create_comment(socket.assigns.post, args) do
      {:ok, comment} ->
        post = socket.assigns.post
        post = %{post | comments: [comment | post.comments]}
        {:noreply, 
          socket
          |> assign(:post, post)
          # not sure what is a better way to clear the form after submission
          |> assign(:new_comment, dbg(Comment.changeset(%Comment{}, %{"author" => nil, "text" => nil})))
        }

      {:error, reason} ->
        {:noreply, 
        socket
        |> put_flash(:error, "Comment couldn't be created: #{inspect(reason)}")}
    end
  end
end
