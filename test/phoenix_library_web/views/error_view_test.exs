defmodule PhoenixLibraryWeb.ErrorViewTest do
  use PhoenixLibraryWeb.ConnCase, async: true

  # Bring render/3 and render_to_string/3 for testing custom views
  import Phoenix.View

  alias PhoenixLibrary.Book

  test "renders 404.json" do
    message = %{message: {:error, "Not found!"}}

    expected_response = %{
      message: "Not found!",
      status: "error"
    }

    assert render(PhoenixLibraryWeb.ErrorView, "404.json", message) == expected_response
  end

  test "renders 400.json" do
    changeset = Book.changeset_create(%{})

    expected_response = %{
      message: %{
        authorship: ["can't be blank"],
        publisher: ["can't be blank"],
        title: ["can't be blank"]
      },
      status: "error"
    }

    assert render(PhoenixLibraryWeb.ErrorView, "400.json", %{changeset: changeset}) ==
             expected_response
  end
end
