defmodule Morsecipher.Repo do
  use Ecto.Repo,
    otp_app: :morsecipher,
    adapter: Ecto.Adapters.Postgres
end
