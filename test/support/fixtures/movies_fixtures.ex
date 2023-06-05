defmodule MovieRater.MoviesFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `MovieRater.Movies` context.
  """

  @doc """
  Generate a movie.
  """
  def movie_fixture(attrs \\ %{}) do
    {:ok, movie} =
      attrs
      |> Enum.into(%{
        description: "some description",
        title: "some title"
      })
      |> MovieRater.Movies.create_movie()

    movie
  end
end
