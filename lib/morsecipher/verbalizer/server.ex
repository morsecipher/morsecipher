defmodule Morsecipher.Verbalizer.Server do
  use GenServer

  def start_link(_opts) do
    Tortoise.Connection.start_link(
      client_id: Morsecipher,
      server: {Tortoise.Transport.Tcp, host: "localhost", port: 1883},
      user_name: System.get_env("MOSQUITTO_USERNAME"),
      password: System.get_env("MOSQUITTO_PASSWORD"),
      handler: {Tortoise.Handler.Logger, []}
    )
  end

  def init(init_arg) do
    {:ok, init_arg}
  end
end
