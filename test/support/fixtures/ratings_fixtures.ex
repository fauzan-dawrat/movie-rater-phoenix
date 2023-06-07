defmodule MovieRater.RatingsFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `MovieRater.Ratings` context.
  """

  @doc """
  Generate a rating.
  """
  def rating_fixture(attrs \\ %{}) do
    {:ok, rating} =
      attrs
      |> Enum.into(%{
        stars: 42
      })
      |> MovieRater.Ratings.create_rating()

    rating
  end
end
