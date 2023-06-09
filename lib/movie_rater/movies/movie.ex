defmodule MovieRater.Movies.Movie do
  use Ecto.Schema
  @derive {Jason.Encoder, only: [:id, :title, :description]} # Used to encode the data from the database in JSON Format
  import Ecto.Changeset

  schema "movies" do
    field :description, :string
    field :title, :string

    has_many :ratings, Rating

    timestamps()
  end

  @doc false
  def changeset(movie, attrs) do
    movie
    |> cast(attrs, [:title, :description])
    |> validate_required([:title, :description])
  end
end
