defmodule Cbt.ExperimentFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Cbt.Experiment` context.
  """

  @doc """
  Generate a task.
  """
  def task_fixture(attrs \\ %{}) do
    {:ok, task} =
      attrs
      |> Enum.into(%{
        name: "some name",
        url: "some url"
      })
      |> Cbt.Experiment.create_task()

    task
  end
end
