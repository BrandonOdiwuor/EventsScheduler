defmodule EventsScheduler.LayoutView do
  use EventsScheduler.Web, :view

  def name(email) do
    split_email = String.split(email, "@")
    first_and_sirname = List.first(split_email)
    split_names = String.split(first_and_sirname, ".")

    first_name = String.capitalize(List.first(split_names))
    last_name = ""

    if count(split_names) == 2 do
      last_name = String.capitalize(List.last(split_names))
    else
      last_name = ""
    end

    name = first_name <> " " <> last_name
  end

  def count(list) do
    _count(list, 0)
  end

  defp _count([], acc) do
    acc
  end
  defp _count([head | tail], acc) do
    _count(tail, acc + 1)
  end
end
