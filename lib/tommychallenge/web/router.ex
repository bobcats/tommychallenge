defmodule Tommychallenge.Web.Router do
  use Tommychallenge.Web, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/api", Tommychallenge.Web do
    pipe_through :api

    resources "/songs", SongController, except: [:new, :edit]
    resources "/submissions", SubmissionController, except: [:new, :edit]
  end
end
