defmodule MovieRaterWeb.ErrorJSONTest do
  use MovieRaterWeb.ConnCase, async: true

  test "renders 404" do
    assert MovieRaterWeb.ErrorJSON.render("404.json", %{}) == %{errors: %{detail: "Not Found"}}
  end

  test "renders 500" do
    assert MovieRaterWeb.ErrorJSON.render("500.json", %{}) ==
             %{errors: %{detail: "Internal Server Error"}}
  end
end
