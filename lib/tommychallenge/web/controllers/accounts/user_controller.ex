defmodule Tommychallenge.Web.Accounts.UserController do
  use Tommychallenge.Web, :controller

  alias Tommychallenge.Accounts.User
  alias Tommychallenge.Repo

  action_fallback Tommychallenge.Web.FallbackController

  def create(conn, %{"user" => user_params}) do
    changeset = User.registration_changeset(%User{}, user_params)

    case Repo.insert(changeset) do
      {:ok, user} ->
        conn
        |> put_status(:created)
        |> render("show.json", user: user)
      {:error, changeset} ->
        conn
        |> put_status(:unprocessable_entity)
        |> render(Tommychallenge.Web.ChangesetView, "error.json", changeset: changeset)
    end
  end
end