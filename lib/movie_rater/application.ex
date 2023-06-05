defmodule MovieRater.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      # Start the Telemetry supervisor
      MovieRaterWeb.Telemetry,
      # Start the Ecto repository
      MovieRater.Repo,
      # Start the PubSub system
      {Phoenix.PubSub, name: MovieRater.PubSub},
      # Start Finch
      {Finch, name: MovieRater.Finch},
      # Start the Endpoint (http/https)
      MovieRaterWeb.Endpoint
      # Start a worker by calling: MovieRater.Worker.start_link(arg)
      # {MovieRater.Worker, arg}
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: MovieRater.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    MovieRaterWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
