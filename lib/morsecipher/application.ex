defmodule Morsecipher.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  def start(_type, _args) do
    children = [
      # Start the Ecto repository
      # Morsecipher.Repo,
      # Start the Telemetry supervisor
      MorsecipherWeb.Telemetry,
      # Start the PubSub system
      {Phoenix.PubSub, name: Morsecipher.PubSub},
      # Start the Endpoint (http/https)
      MorsecipherWeb.Endpoint,
      # Start a worker by calling: Morsecipher.Worker.start_link(arg)
      # {Morsecipher.Worker, arg}
      Morsecipher.QueueInterpreter,
      Morsecipher.QueuePoller,
      {
        Tortoise.Connection,
        [
          client_id: Morsecipher,
          server: {Tortoise.Transport.Tcp, host: System.get_env("MOSQUITTO_SERVER"), port: 1883},
          user_name: System.get_env("MOSQUITTO_USERNAME"),
          password: System.get_env("MOSQUITTO_PASSWORD"),
          handler: {
            Tortoise.Handler.Logger, []
          }
        ]
      }
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: Morsecipher.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  def config_change(changed, _new, removed) do
    MorsecipherWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
