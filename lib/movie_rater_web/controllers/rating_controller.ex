defmodule MovieRaterWeb.RatingController do
  use MovieRaterWeb, :controller

  alias MovieRater.Ratings
  alias MovieRater.Ratings.Rating
  alias MovieRater.Repo


  def index(conn, _params) do
    ratings = Ratings.list_ratings()
    json(conn,  %{ratings: ratings})
  end

  def new(conn, _params) do
    changeset = Ratings.change_rating(%Rating{})
    render(conn, :new, changeset: changeset)
  end


  def create(conn, %{"stars" => stars, "movie_id" => movie_id} = _params) do
    if stars === "" or movie_id === "" do
      json(conn, %{Error: "Stars and Movie ID cannot be empty!"})
    else
      rating_params = %{
        stars: stars,
        movie_id: movie_id
      }
      # IO.puts(description)
      # IO.inspect(rating_params)
      case Ratings.create_rating(rating_params) do
        {:ok, _movie} ->
          json(conn, %{Message: "Rating Created Successfully!"})

        {:error, _changeset} ->
          json(conn, %{Error: "Unexpected error occurred!"})
        {:error} ->
          json(conn, %{Error: "Rating Already created!"})

      end
    end
  end

  def create(conn, _params) do # Function will execute if title or description is not present in the request
  json(conn, %{Error: "Stars and Movie ID are required!"})
  end

  def show(conn, %{"id" => id}) do
    rating = Ratings.get_rating!(id)
    json(conn,  %{rating: rating})
  end

  def edit(conn, %{"id" => id}) do
    rating = Ratings.get_rating!(id)
    changeset = Ratings.change_rating(rating)
    render(conn, :edit, rating: rating, changeset: changeset)
  end


  def update(conn, %{"id" => id, "stars" => stars, "movie_id" => movie_id}) do
    if movie_id === "" or stars === "" do
      json(conn, %{Error: "Movie ID and Stars cannot be empty!"})
    else
      case Ratings.get_rating!(id) do
        nil ->
          json(conn, %{error: "Rating not found!"})
        rating ->
          movie_params = %{movie_id: movie_id, stars: stars}
          case Ratings.update_rating(rating, movie_params) do
            {:ok, _rating} ->
              json(conn, %{message: "Rating updated successfully!"})
            {:error, _changeset} ->
              json(conn, %{error: "Unexpected error occurred!"})
          end
      end
    end
  end

  def update(conn, _params) do # Function will execute if title or description is not present in the request
  json(conn, %{Error: "Movie ID and Stars are required!"})
  end



  def delete(conn, %{"id" => id}) do
    case Repo.get(Ratings.Rating, id) do
      nil ->
        json(conn, %{message: "Rating not found"})

      rating ->
        {:ok, _} = Ratings.delete_rating(rating)
        json(conn, %{message: "Rating has been deleted!"})
    end
  end
end
