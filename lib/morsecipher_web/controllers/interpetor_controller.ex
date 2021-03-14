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
    Morsecipher.QueueInterpreter.add(%{ text: params["text"], adapter: params["adapter"]})

    json conn, %{ status: :ok }
  end
end
