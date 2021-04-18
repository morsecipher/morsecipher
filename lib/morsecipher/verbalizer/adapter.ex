defmodule Morsecipher.Verbalizer.Adapter do
  @behaviour Morseficator.Adapter
  @unit 55

  @spec setup :: {}
  def setup do
    {}
  end

  @spec beep(pid, non_neg_integer()) :: :ok
  def beep(_, times) do
    :ok = Tortoise.publish(Morsecipher, "morse/msg", "1")
    :timer.sleep(@unit*times)
    :ok = Tortoise.publish(Morsecipher, "morse/msg", "0")
  end

  @spec sleep(any) :: :ok
  def sleep(n) do
    :timer.sleep(@unit*n)
  end
end
