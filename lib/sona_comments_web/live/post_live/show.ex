defmodule SonaCommentsWeb.PostLive.Show do
  use SonaCommentsWeb, :live_view

  alias Phoenix.PubSub
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

    if connected?(socket), do: PubSub.subscribe(SonaComments.PubSub, slug)

    {:noreply,
     socket
     |> assign(:page_title, post.title)
     |> assign(:post, post)
     |> assign(:new_comment, Comment.changeset(%Comment{}, %{}))}
  end

  @impl true
  def handle_event("new_comment", %{"comment" => %{"author" => author, "text" => text} = args}, socket) do
    post = socket.assigns.post

    case Content.create_comment(post, args) do
      {:ok, comment} ->
        PubSub.broadcast(SonaComments.PubSub, post.slug, {:new_comment, comment, self()})

        {:noreply, 
          socket
          # not sure what is a better way to clear the form after submission
          |> assign(:new_comment, Comment.changeset(%Comment{}, %{"author" => nil, "text" => nil}))
        }

      {:error, reason} ->
        {:noreply, 
        socket
        |> put_flash(:error, "Comment couldn't be created: #{inspect(reason)}")}
    end
  end

  @impl true
  def handle_info({:new_comment, comment, pid}, socket) do
      post = socket.assigns.post
      post = %{post | comments: [comment | post.comments]}
          {:noreply, 
            socket
            |> assign(:post, post)}
  end
end
