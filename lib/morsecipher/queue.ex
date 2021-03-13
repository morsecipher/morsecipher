defmodule Morsecipher.Queue do
  use GenServer

  # Client
  def start_link(_) do
    GenServer.start_link(__MODULE__, [], name: Morsecipher.Queue)
  end

  def add(pid, text) do
    GenServer.cast(pid, text)
  end

  def pop(pid) do
    GenServer.call(pid, :pop)
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

  def handle_cast(text, queue) do
    updated_queue = [text|queue]
    {:noreply, updated_queue}
  end
end
