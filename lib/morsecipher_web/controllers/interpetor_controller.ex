defmodule MorsecipherWeb.InterpetorController do
  use MorsecipherWeb, :controller

  def encode(conn, params) do
    output = Morseficator.encode(params["text"])
    json(conn, %{status: :ok, text: output})
  end

  def decode(conn, params) do
    output = Morseficator.decode(params["text"])
    json(conn, %{status: :ok, text: output})
  end

  def create(conn, %{"text" => text, "adapter" => adapter}) do
    {state, msg} = cond do
      String.length(text) > 11 ->
        {:error, "The message is too long"}
      true ->
        Morsecipher.QueueInterpreter.add(%{text: text, adapter: adapter})
        {:ok, "Interpreting"}
    end

    json(conn, %{status: state, msg: msg})
  end
end
