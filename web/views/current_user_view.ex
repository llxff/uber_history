defmodule UberHistory.CurrentUserView do
  use UberHistory.Web, :view

  def render("show.json", %{user: user}) do
    %{ user: user }
  end
end
