defmodule PhoenixLibrary.Repo do
  use Ecto.Repo,
    otp_app: :phoenix_library,
    adapter: Ecto.Adapters.Postgres
end
