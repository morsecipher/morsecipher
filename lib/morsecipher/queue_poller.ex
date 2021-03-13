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
    list = GenServer.whereis(Morsecipher.Queue)
           |> Morsecipher.Queue.pop

    case list do
      nil -> :timer.sleep(@interval)
      _ -> Morseficator.Adapter.interpret(list[:text], list[:adapter])
    end
  end
end
