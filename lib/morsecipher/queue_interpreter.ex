defmodule Morsecipher.QueueInterpreter do
  use GenServer

  # Client
  def start_link(_) do
    GenServer.start_link(__MODULE__, [], name: __MODULE__)
  end

  def add(params) do
    GenServer.cast(pid(), %{ text: params[:text], adapter: map_adapter(params[:adapter]) })
  end

  def pop do
    GenServer.call(pid(), :pop)
  end

  # Server
  def init(queue) do
    {:ok, queue}
  end

  def handle_call(:pop, _from, []), do: {:reply, nil, []}
  def handle_call(:pop, _from, queue) do
    { last, rest } = List.pop_at(queue, -1)
    {:reply, last, rest}
  end

  def handle_cast(list, queue) do
    updated_queue = [list|queue]
    {:noreply, updated_queue}
  end

  defp map_adapter(adapter) do
    case adapter do
      "printer" -> Morseficator.Adapter.Printer
      _ -> Morseficator.Adapter.Midi
    end
  end

  defp pid do
    GenServer.whereis(__MODULE__)
  end
end
