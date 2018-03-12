defmodule HomeController do
  use Tommychallenge.Web, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
