defmodule Talk.Repo do
  use Ecto.Repo,
    otp_app: :talk,
    adapter: Ecto.Adapters.Postgres
end
