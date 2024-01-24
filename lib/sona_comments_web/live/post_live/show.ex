defmodule SonaCommentsWeb.PostLive.Show do
  use SonaCommentsWeb, :live_view

  alias SonaComments.Content

  @impl true
  def mount(_params, _session, socket) do
    {:ok, socket}
  end

  @impl true
  def handle_params(%{"slug" => slug}, _, socket) do
    dbg(slug)
    {:noreply,
     socket
     |> assign(:page_title, page_title(socket.assigns.live_action))
     |> assign(:post, Content.get_post_by_slug!(slug))}
  end

  defp page_title(:show), do: "Show Post"
  defp page_title(:edit), do: "Edit Post"
end
