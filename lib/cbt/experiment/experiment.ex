defmodule Cbt.Experiment do
  @moduledoc """
  The Experiment context.
  """

  import Ecto.Query, warn: false
  alias Cbt.Accounts
  alias Cbt.Experiment.Task
  alias Cbt.Repo

  def list_tasks do
    Repo.all(Task)
  end

  def get_task!(id), do: Repo.get!(Task, id)

  def create_task(%Accounts.Experimenter{} = experimenter, attrs \\ %{}) do
    %Task{}
    |> Task.changeset(attrs)
    |> Ecto.Changeset.put_assoc(:experimenter, experimenter)
    |> Repo.insert()
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
end
