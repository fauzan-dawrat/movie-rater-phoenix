defmodule MovieRater.Repo do
  use Ecto.Repo,
    otp_app: :movie_rater,
    adapter: Ecto.Adapters.Postgres
end
