defmodule PhoenixLibraryWeb.ErrorView do
  use PhoenixLibraryWeb, :view

  import Ecto.Changeset, only: [traverse_errors: 2]

  # If you want to customize a particular status code
  # for a certain format, you may uncomment below.
  # def render("500.json", _assigns) do
  #   %{errors: %{detail: "Internal Server Error"}}
  # end

  def render("404.json", %{message: message}) do
    %{
      status: "fail",
      data: %{book: message}
    }
  end

  def render("400.json", %{changeset: changeset}) do
    %{
      status: "fail",
      data: translate_errors(changeset)
    }
  end

  defp translate_errors(changeset) do
    traverse_errors(changeset, fn {msg, opts} ->
      Regex.replace(~r"%{(\w+)}", msg, fn _, key ->
        opts |> Keyword.get(String.to_existing_atom(key), key) |> to_string()
      end)
    end)
  end

  # # By default, Phoenix returns the status message from
  # # the template name. For example, "404.json" becomes
  # # "Not Found".
  # def template_not_found(template, _assigns) do
  #   %{errors: %{detail: Phoenix.Controller.status_message_from_template(template)}}
  # end
end
