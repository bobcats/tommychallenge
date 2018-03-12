defmodule Tommychallenge.Web.Router do
  use Tommychallenge.Web, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  get "/", HomeController, :index

  scope "/api", Tommychallenge.Web do
    pipe_through :api

    resources "/songs", SongController, except: [:new, :edit]
    resources "/submissions", SubmissionController, except: [:new, :edit]
    resources "/users", Accounts.UserController, only: [:create]
    resources "/sessions", Accounts.SessionController, only: [:create]
  end
end
