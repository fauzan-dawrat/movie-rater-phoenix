defmodule MovieRaterWeb.RatingHTML do
  use MovieRaterWeb, :html

  embed_templates "rating_html/*"

  @doc """
  Renders a rating form.
  """
  attr :changeset, Ecto.Changeset, required: true
  attr :action, :string, required: true

  def rating_form(assigns)
end
