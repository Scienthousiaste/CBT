defmodule Cbt.Experiment.DefaultQuestions do
  @default_task_name "Default CBT"

  alias Cbt.Experiment.Question
  alias Cbt.Experiment.Task

  alias Cbt.Repo

  def get_default_task_name, do: @default_task_name

  def get_default_questions do
    [
      %{text: "Sex", type_answer: :multiple_choice, choices: ["Male", "Female", "Intersex"]},
      %{text: "Age", type_answer: :boolean},
      %{text: "Years of education", type_answer: :integer}
    ]
  end

  # Remove the default task(s) created
  def remove_all_default_tasks do
    Repo.all(Task, name: @default_task_name)
    |> Enum.each(fn task ->
      Repo.all(Question, question_id: task.id)
      |> Enum.each(fn question ->
        Repo.delete!(question)
      end)

      Repo.delete!(task)
    end)
  end
end
