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

  describe "questions" do
    alias Cbt.Experiment.Question

    import Cbt.ExperimentFixtures

    @invalid_attrs %{default: nil, text: nil, type_answer: nil}

    test "get_question!/1 returns the question with given id" do
      question = question_fixture()
      assert Experiment.get_question!(question.id) == question
    end

    test "create_question/1 with valid data creates a question" do
      valid_attrs = %{default: true, text: "some text", type_answer: :unique_choice}

      assert {:ok, %Question{} = question} = Experiment.create_question(valid_attrs)
      assert question.default == true
      assert question.text == "some text"
      assert question.type_answer == :unique_choice
    end

    test "create_question/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Experiment.create_question(@invalid_attrs)
    end

    test "update_question/2 with valid data updates the question" do
      question = question_fixture()
      update_attrs = %{default: false, text: "some updated text", type_answer: :multiple_choice}

      assert {:ok, %Question{} = question} = Experiment.update_question(question, update_attrs)
      assert question.default == false
      assert question.text == "some updated text"
      assert question.type_answer == :multiple_choice
    end

    test "update_question/2 with invalid data returns error changeset" do
      question = question_fixture()
      assert {:error, %Ecto.Changeset{}} = Experiment.update_question(question, @invalid_attrs)
      assert question == Experiment.get_question!(question.id)
    end

    test "delete_question/1 deletes the question" do
      question = question_fixture()
      assert {:ok, %Question{}} = Experiment.delete_question(question)
      assert_raise Ecto.NoResultsError, fn -> Experiment.get_question!(question.id) end
    end

    test "change_question/1 returns a question changeset" do
      question = question_fixture()
      assert %Ecto.Changeset{} = Experiment.change_question(question)
    end
  end
end
