defmodule Morsecipher.Verbalizer.Adapter do
  @behaviour Morseficator.Adapter
  @unit 55

  @spec setup :: {}
  def setup do
    {}
  end

  @spec beep(pid, non_neg_integer()) :: :ok
  def beep(_, times) do
    {:ok, ref} = Tortoise.publish(Morsecipher, "morse/msg", "1", qos: 2)
    :timer.sleep(@unit*times)
    {:ok, ref} = Tortoise.publish(Morsecipher, "morse/msg", "0", qos: 2)
    :ok
  end

  @spec sleep(any) :: :ok
  def sleep(n) do
    :timer.sleep(@unit*n)
  end
end
