defmodule Tommychallenge.Web.Router do
  use Tommychallenge.Web, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", Tommychallenge.Web do
    pipe_through :browser # Use the default browser stack

    get "/", PageController, :index
  end

  # Other scopes may use custom stacks.
  scope "/api", Tommychallenge.Web do
    pipe_through :api

    resources "/songs", SongController, except: [:new, :edit]
    resources "/submissions", SubmissionController, except: [:new, :edit]
  end
end
