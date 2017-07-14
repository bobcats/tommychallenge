defmodule Tommychallenge.Web.PageController do
  use Tommychallenge.Web, :controller

  def index(conn, _params) do
    render conn, "index.html"
  end
end
