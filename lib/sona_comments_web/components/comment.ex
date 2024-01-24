defmodule SonaCommentsWeb.Comment do
  use Phoenix.Component

  def comment(assigns) do
    ~H"""
    <div class="mt-4 py-4 flex border-b border-zinc-200">
      <div class="flex-grow">
        <p><%= @comment.text %></p>
        <p class="font-semibold"><%= @comment.author %></p>
      </div>
      <div>
        <p class="text-sm text-zinc-700"><%= Calendar.strftime(@comment.inserted_at, "%y-%m-%d %I:%M:%S %p") %></p>
      </div>
    </div>
    """
  end
end
