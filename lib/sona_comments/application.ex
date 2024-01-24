defmodule SonaComments.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      SonaCommentsWeb.Telemetry,
      SonaComments.Repo,
      {Phoenix.PubSub, name: SonaComments.PubSub},
      {DNSCluster, query: Application.get_env(:sona_comments, :dns_cluster_query) || :ignore},
      {Phoenix.PubSub, name: SonaComments.PubSub},
      # Start the Finch HTTP client for sending emails
      {Finch, name: SonaComments.Finch},
      # Start a worker by calling: SonaComments.Worker.start_link(arg)
      # {SonaComments.Worker, arg},
      # Start to serve requests, typically the last entry
      SonaCommentsWeb.Endpoint
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: SonaComments.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    SonaCommentsWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
