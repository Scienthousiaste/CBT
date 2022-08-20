defmodule Cbt.Repo do
  use Ecto.Repo,
    otp_app: :cbt,
    adapter: Ecto.Adapters.Postgres
end
