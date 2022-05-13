defmodule PhoenixLibrary.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  def start(_type, _args) do
    children = [
      # Start the Ecto repository
      PhoenixLibrary.Repo,
      # Start the Telemetry supervisor
      PhoenixLibraryWeb.Telemetry,
      # Start the PubSub system
      {Phoenix.PubSub, name: PhoenixLibrary.PubSub},
      # Start the Endpoint (http/https)
      PhoenixLibraryWeb.Endpoint
      # Start a worker by calling: PhoenixLibrary.Worker.start_link(arg)
      # {PhoenixLibrary.Worker, arg}
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: PhoenixLibrary.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  def config_change(changed, _new, removed) do
    PhoenixLibraryWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
