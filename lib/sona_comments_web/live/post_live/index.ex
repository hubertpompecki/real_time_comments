defmodule SonaCommentsWeb.PostLive.Index do
  use SonaCommentsWeb, :live_view

  alias SonaComments.Content

  @impl true
  def mount(_params, _session, socket) do
    {:ok, stream(socket, :posts, Content.list_posts())}
  end

  @impl true
  def handle_params(params, _url, socket) do
    {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  end

  defp apply_action(socket, :index, _params) do
    socket
    |> assign(:page_title, "Listing Posts")
    |> assign(:post, nil)
  end
end
