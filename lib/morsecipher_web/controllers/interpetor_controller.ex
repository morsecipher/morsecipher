defmodule MorsecipherWeb.InterpetorController do
  use MorsecipherWeb, :controller

  def encode(conn, params) do
    output = Morseficator.encode(params["text"])
    json conn, %{ status: :ok, text: output }
  end

  def decode(conn, params) do
    output = Morseficator.decode(params["text"])
    json conn, %{ status: :ok, text: output }
  end
  def create(conn, params) do
    GenServer.whereis(Morsecipher.Queue)
    |> Morsecipher.Queue.add(%{ text: params["text"], adapter: map_adapter(params["adapter"])})

    json conn, %{ status: :ok }
  end

  defp map_adapter(adapter) do
    case adapter do
      "printer" -> Morseficator.Adapter.Printer
      _ -> Morseficator.Adapter.Midi
    end
  end
end
