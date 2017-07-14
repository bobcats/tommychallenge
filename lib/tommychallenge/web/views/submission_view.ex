defmodule Tommychallenge.Web.SubmissionView do
  use Tommychallenge.Web, :view
  alias Tommychallenge.Web.SubmissionView

  def render("index.json", %{submissions: submissions}) do
    %{data: render_many(submissions, SubmissionView, "submission.json")}
  end

  def render("show.json", %{submission: submission}) do
    %{data: render_one(submission, SubmissionView, "submission.json")}
  end

  def render("submission.json", %{submission: submission}) do
    %{id: submission.id,
      title: submission.title,
      artist: submission.artist,
      link: submission.link,
      upvotes: submission.upvotes,
      downvotes: submission.downvotes}
  end
end
