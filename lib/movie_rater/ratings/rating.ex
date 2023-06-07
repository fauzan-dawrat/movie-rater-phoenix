defmodule MovieRater.Ratings.Rating do
  use Ecto.Schema
  import Ecto.Changeset
  @derive {Jason.Encoder, only: [:id, :movie_id, :stars]} # Used to encode the data from the database in JSON Format


  schema "ratings" do
    field :stars, :integer

    belongs_to :movie, MovieRater.Movies.Movie

    timestamps()
  end

  @doc false
  def changeset(rating, attrs) do
    rating
    |> cast(attrs, [:stars, :movie_id])
    |> validate_required([:stars, :movie_id])
  end
end
