defmodule MovieRaterWeb.MovieController do
  use MovieRaterWeb, :controller

  alias MovieRater.Movies
  alias MovieRater.Movies.Movie
  alias MovieRater.Repo

  def index(conn, _params) do
    movies = Movies.list_movies()
    json(conn,  %{movies: movies})
  end

  def new(conn, _params) do
    changeset = Movies.change_movie(%Movie{})
    render(conn, :new, changeset: changeset)
  end

  # def create(conn, %{"description" => description, "title" => title}) do
  #   movie_params = %{
  #     description: description,
  #     title: title
  #   }

  #   case Movies.create_movie(movie_params) do
  #     {:ok, _movie} ->
  #      text(conn, "CREATED")

  #     {:error, _changeset} ->
  #      text(conn, "ERROR")
  #   end
  # end

  def create(conn, %{"description" => description, "title" => title} = _params) do
    if description === "" or title === "" do
      json(conn, %{Error: "Description and Title cannot be empty!"})
    else
      movie_params = %{
        description: description,
        title: title
      }
      # IO.puts(description)
      # IO.inspect(movie_params)
      case Movies.create_movie(movie_params) do
        {:ok, _movie} ->
          json(conn, %{Message: "Movie Created Successfully!"})

        {:error, _changeset} ->
          json(conn, %{Error: "Unexpected error occurred!"})
      end
    end
  end

  def create(conn, _params) do # Function will execute if title or description is not present in the request
  json(conn, %{Error: "Description and Title are required!"})
  end





  def show(conn, %{"id" => id}) do
    movie = Movies.get_movie!(id)
    json(conn,  %{movie: movie})
  end

  def edit(conn, %{"id" => id}) do
    movie = Movies.get_movie!(id)
    changeset = Movies.change_movie(movie)
    render(conn, :edit, movie: movie, changeset: changeset)
  end

  def update(conn, %{"id" => id, "title" => title, "description" => description}) do
    if description === "" or title === "" do
      json(conn, %{Error: "Description and Title cannot be empty!"})
    else
      case Movies.get_movie!(id) do
        nil ->
          json(conn, %{error: "Movie not found!"})
        movie ->
          movie_params = %{description: description, title: title}
          case Movies.update_movie(movie, movie_params) do
            {:ok, _movie} ->
              json(conn, %{message: "Movie updated successfully!"})
            {:error, _changeset} ->
              json(conn, %{error: "Unexpected error occurred!"})
          end
      end
    end
  end

  def update(conn, _params) do # Function will execute if title or description is not present in the request
  json(conn, %{Error: "Description and Title are required!"})
  end




  def delete(conn, %{"id" => id}) do
    case Repo.get(Movies.Movie, id) do
      nil ->
        json(conn, %{message: "Movie not found"})

      movie ->
        {:ok, _} = Movies.delete_movie(movie)
        json(conn, %{message: "Movie has been deleted!"})
    end
  end



end
