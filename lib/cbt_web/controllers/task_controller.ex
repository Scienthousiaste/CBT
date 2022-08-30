defmodule CbtWeb.TaskController do
  use CbtWeb, :controller

  alias Cbt.Experiment
  alias Cbt.Experiment.Task

  def index(conn, _params, current_experimenter) do
    tasks = Experiment.list_experimenter_tasks(current_experimenter)
    render(conn, "index.html", tasks: tasks)
  end

  def new(conn, _params, _current_experimenter) do
    default_questions = Experiment.default_questions()
    changeset = Experiment.change_task(%Task{})
    render(conn, "new.html", changeset: changeset, questions: default_questions)
  end

  def create(conn, %{"task" => task_params}, current_experimenter) do
    case Experiment.create_task(current_experimenter, task_params) do
      {:ok, task} ->
        conn
        |> put_flash(:info, "Cognitive Bias Task created successfully.")
        |> redirect(to: Routes.task_path(conn, :show, task))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}, current_experimenter) do
    task = Experiment.get_experimenter_task!(current_experimenter, id)
    render(conn, "show.html", task: task)
  end

  def edit(conn, %{"id" => id}, current_experimenter) do
    task = Experiment.get_experimenter_task!(current_experimenter, id)
    changeset = Experiment.change_task(task)
    render(conn, "edit.html", task: task, changeset: changeset)
  end

  def update(conn, %{"id" => id, "task" => task_params}, current_experimenter) do
    task = Experiment.get_experimenter_task!(current_experimenter, id)

    case Experiment.update_task(task, task_params) do
      {:ok, task} ->
        conn
        |> put_flash(:info, "Task updated successfully.")
        |> redirect(to: Routes.task_path(conn, :show, task))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", task: task, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}, current_experimenter) do
    task = Experiment.get_experimenter_task!(current_experimenter, id)
    {:ok, _task} = Experiment.delete_task(task)

    conn
    |> put_flash(:info, "Task deleted successfully.")
    |> redirect(to: Routes.task_path(conn, :index))
  end

  def action(conn, _) do
    args = [conn, conn.params, conn.assigns.current_experimenter]
    apply(__MODULE__, action_name(conn), args)
  end
end
