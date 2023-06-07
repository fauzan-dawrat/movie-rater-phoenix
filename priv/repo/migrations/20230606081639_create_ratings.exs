defmodule MovieRater.Repo.Migrations.CreateRatings do
  use Ecto.Migration

  def change do
    create table(:ratings) do
      add :stars, :integer
      add :movie_id, references(:movies, on_delete: :nothing)

      timestamps()
    end

    create unique_index(:ratings, [:movie_id])
  end
end
