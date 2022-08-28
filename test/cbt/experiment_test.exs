defmodule Cbt.ExperimentTest do
  use Cbt.DataCase

  alias Cbt.Experiment

  describe "tasks" do
    alias Cbt.Experiment.Task

    import Cbt.ExperimentFixtures

    @invalid_attrs %{name: nil, url: nil}

    test "list_tasks/0 returns all tasks" do
      task = task_fixture()
      assert Experiment.list_tasks() == [task]
    end

    test "get_task!/1 returns the task with given id" do
      task = task_fixture()
      assert Experiment.get_task!(task.id) == task
    end

    test "create_task/1 with valid data creates a task" do
      valid_attrs = %{name: "some name", url: "some url"}

      assert {:ok, %Task{} = task} = Experiment.create_task(valid_attrs)
      assert task.name == "some name"
      assert task.url == "some url"
    end

    test "create_task/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Experiment.create_task(@invalid_attrs)
    end

    test "update_task/2 with valid data updates the task" do
      task = task_fixture()
      update_attrs = %{name: "some updated name", url: "some updated url"}

      assert {:ok, %Task{} = task} = Experiment.update_task(task, update_attrs)
      assert task.name == "some updated name"
      assert task.url == "some updated url"
    end

    test "update_task/2 with invalid data returns error changeset" do
      task = task_fixture()
      assert {:error, %Ecto.Changeset{}} = Experiment.update_task(task, @invalid_attrs)
      assert task == Experiment.get_task!(task.id)
    end

    test "delete_task/1 deletes the task" do
      task = task_fixture()
      assert {:ok, %Task{}} = Experiment.delete_task(task)
      assert_raise Ecto.NoResultsError, fn -> Experiment.get_task!(task.id) end
    end

    test "change_task/1 returns a task changeset" do
      task = task_fixture()
      assert %Ecto.Changeset{} = Experiment.change_task(task)
    end
  end
end
