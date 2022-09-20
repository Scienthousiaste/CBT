defmodule Cbt.Experiment do
  @moduledoc """
  The Experiment context.
  """

  import Ecto.Query, warn: false

  alias Cbt.Accounts
  alias Cbt.Experiment.DefaultQuestions
  alias Cbt.Experiment.Question
  alias Cbt.Experiment.Task
  alias Cbt.Repo
  alias Ecto.Changeset

  def list_tasks do
    Repo.all(Task)
  end

  def get_task!(id), do: Repo.get!(Task, id)

  def create_task(%Accounts.Experimenter{} = experimenter, attrs \\ %{}) do
    # TODOs:
    # - put assoc with questions

    %Task{}
    |> Task.changeset(attrs)
    |> Changeset.put_assoc(:experimenter, experimenter)
    |> Changeset.put_change(:url, Cbt.URL.generate_url())
    |> Repo.insert()
  end

  def create_task_questionnaire(%Accounts.Experimenter{} = experimenter, task, attrs \\ %{}) do
    require IEx; IEx.pry
    nil
  end

  def update_task(%Task{} = task, attrs) do
    task
    |> Task.changeset(attrs)
    |> Repo.update()
  end

  def delete_task(%Task{} = task) do
    Repo.delete(task)
  end

  def change_task(%Task{} = task, attrs \\ %{}) do
    Task.changeset(task, attrs)
  end

  def list_experimenter_tasks(%Accounts.Experimenter{} = experimenter) do
    Task
    |> experimenter_task_query(experimenter)
    |> Repo.all()
  end

  def get_experimenter_task!(%Accounts.Experimenter{} = experimenter, id) do
    Task
    |> experimenter_task_query(experimenter)
    |> Repo.get!(id)
  end

  defp experimenter_task_query(query, %Accounts.Experimenter{id: experimenter_id}) do
    from(v in query, where: v.experimenter_id == ^experimenter_id)
  end

  def default_questions() do
    DefaultQuestions.get_default_questions()
  end

  def get_experiment_questions(%Task{id: task_id}) do
    from(q in Question, where: q.task_id == ^task_id)
    |> Repo.all()
  end

  def get_question!(id), do: Repo.get!(Question, id)

  def create_question(attrs \\ %{}) do
    %Question{}
    |> Question.changeset(attrs)
    |> Repo.insert()
  end

  def update_question(%Question{} = question, attrs) do
    question
    |> Question.changeset(attrs)
    |> Repo.update()
  end

  def delete_question(%Question{} = question) do
    Repo.delete(question)
  end

  def change_question(%Question{} = question, attrs \\ %{}) do
    Question.changeset(question, attrs)
  end
end
