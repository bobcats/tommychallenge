defmodule Tommychallenge.Web.Accounts.UserView do
  use Tommychallenge.Web, :view
  alias Tommychallenge.Web.Accounts.UserView

  def render("show.json", %{user: user}) do
    %{data: render_one(user, UserView, "user.json")}
  end

  def render("user.json", %{user: user}) do
    %{
      id: user.id,
      username: user.username,
      name: user.name,
      email: user.email
    }
  end
end