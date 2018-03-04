defmodule Tommychallenge.Web.Accounts.SessionView do
  use Tommychallenge.Web, :view
  alias Tommychallenge.Web.Accounts.SessionView

  def render("show.json", %{session: session}) do
    %{data: render_one(session, SessionView, "session.json")}
  end

  def render("session.json", %{session: session}) do
    %{token: session.token}
  end

  def render("error.json", _anything) do
    %{errors: "Failed to authenticate"}
  end
end