require IEx

defmodule Morsecipher.QueuePoller do
  use Task

  @interval 1000

  def start_link(_opts) do
    Task.start_link(&poll/0)
  end

  def poll do
    receive do
    after
      @interval ->
        interpret()
        poll()
    end
  end

  defp interpret do
    pid = GenServer.whereis(Morsecipher.Queue)
    msg = Morsecipher.Queue.pop(pid)

    case msg do
      nil -> :timer.sleep(@interval)
      _ -> Morseficator.Adapter.interpret(msg, Morseficator.Adapter.Midi)
    end
  end
end
