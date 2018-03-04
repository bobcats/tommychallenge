defmodule Tommychallenge.Web.Accounts.SessionController do
  use Tommychallenge.Web, :controller

  import Comeonin.Pbkdf2, only: [checkpw: 2, dummy_checkpw: 0]

  alias Tommychallenge.Accounts.Session
  alias Tommychallenge.Accounts.User
  alias Tommychallenge.Repo

  action_fallback Tommychallenge.Web.FallbackController

  def create(conn, %{"user" => user_params}) do
    user = Repo.get_by(User, email: user_params["email"])
    cond do
      user && checkpw(user_params["password"], user.password_hash) ->
        changeset = Session.create_changeset(%Session{}, %{user_id: user.id})
        {:ok, session} = Repo.insert(changeset)
        conn
        |> put_status(:created)
        |> render("show.json", session: session)
      user ->
        conn
        |> put_status(:unauthorized)
        |> render("error.json", user_params)
      # If a user is not found, fake a password check and return :unauthorized as an
      # additional security measure.
      true ->
        dummy_checkpw
        conn
        |> put_status(:unauthorized)
        |> render("error.json", user_params)
    end
  end
end