defmodule Cbt.Experiment.QuestionChoice do
  use Ecto.Schema
  import Ecto.Changeset

  schema "question_choices" do
    field :text, :string

    belongs_to :question, Cbt.Experiment.Question
  end

  @doc false
  def changeset(question_choice, attrs) do
    question_choice
    |> cast(attrs, [:text, :question_id])
    |> validate_required([:text, :question_id])
  end
end
