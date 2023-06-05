defmodule MovieRaterWeb.MovieHTML do
  use MovieRaterWeb, :html

  embed_templates "movie_html/*"

  @doc """
  Renders a movie form.
  """
  attr :changeset, Ecto.Changeset, required: true
  attr :action, :string, required: true

  def movie_form(assigns)
end
