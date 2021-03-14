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
    next_item = Morsecipher.QueueInterpreter.pop

    case next_item do
      nil -> :timer.sleep(@interval)
      _ -> Morseficator.Adapter.interpret(next_item[:text], next_item[:adapter])
    end
  end
end
