# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     Cbt.Repo.insert!(%Cbt.SomeSchema{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.

# Test that the default user/task don't exist before seeding
alias Cbt.Experiment.DefaultQuestions
alias Cbt.Experiment.Question
alias Cbt.Experiment.QuestionChoice
alias Cbt.Experiment.Task
alias Cbt.Repo

default_task_name = DefaultQuestions.get_default_task_name()

if !Repo.get_by(Task, name: default_task_name) do
  default_task =
    Repo.insert!(%Task{
      name: default_task_name
    })

  DefaultQuestions.get_default_questions()
  |> Enum.each(fn q_attributes ->
    attrs =
      q_attributes
      |> Map.put(:is_default, true)
      |> Map.put(:task_id, default_task.id)
      |> Map.delete(:choices)

    # remove choices here if exist

    question =
      %Question{}
      |> Question.changeset(attrs)
      |> Repo.insert!()

    case Map.get(q_attributes, :choices) do
      nil ->
        nil

      choices ->
        choices
        |> Enum.each(fn choice ->
          %QuestionChoice{}
          |> QuestionChoice.changeset(%{text: choice, question_id: question.id})
          |> Repo.insert!()
        end)
    end
  end)
end
