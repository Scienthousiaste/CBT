defmodule CbtWeb.TaskController do
  use CbtWeb, :controller

  alias Cbt.Experiment
  alias Cbt.Experiment.Task

  alias Plug.Conn

  plug Cbt.AccessControl.AccessAndAssignExperiment when action in [:show, :edit, :update, :delete, :new_form, :create_form_for_task]

  def index(conn, _params, current_experimenter) do
    tasks = Experiment.list_experimenter_tasks(current_experimenter)
    render(conn, "index.html", tasks: tasks)
  end

  def new(conn, _params, _current_experimenter) do
    changeset = Experiment.change_task(%Task{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"task" => task_params}, current_experimenter) do
    case Experiment.create_task(current_experimenter, task_params) do
      {:ok, task} ->
        conn
        |> put_flash(:info, "Cognitive Bias Task created successfully.")
        |> redirect(to: Routes.task_path(conn, :new_form, task))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(%Conn{assigns: %{task: task}} = conn, _, _current_experimenter) do
    render(conn, "show.html", task: task)
  end

  def edit(%Conn{assigns: %{task: task}} = conn, _, _current_experimenter) do
    changeset = Experiment.change_task(task)
    render(conn, "edit.html", task: task, changeset: changeset)
  end

  def update(%Conn{assigns: %{task: task}} = conn, %{"task" => task_params}, _current_experimenter) do
    case Experiment.update_task(task, task_params) do
      {:ok, task} ->
        conn
        |> put_flash(:info, "Task updated successfully.")
        |> redirect(to: Routes.task_path(conn, :show, task))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", task: task, changeset: changeset)
    end
  end

  def delete(%Conn{assigns: %{task: task}} = conn, _, _current_experimenter) do
    {:ok, _task} = Experiment.delete_task(task)

    conn
    |> put_flash(:info, "Task deleted successfully.")
    |> redirect(to: Routes.task_path(conn, :index))
  end

  def new_form(%Conn{assigns: %{task: task}} = conn, _, _current_experimenter) do
    changeset = Experiment.change_task(task)

    render(conn, "new_form.html",
      task: task,
      changeset: changeset
    )
  end

  def create_form_for_task(%Conn{assigns: %{task: task}} = conn, %{"task" => task_params}, current_experimenter) do
    #TODO: Now, need to find how to get the proper final state of the form from the JavaScript
    require IEx
    IEx.pry()
    # case Experiment.create_task_questionnaire(current_experimenter, task, []) do
    #   nil -> render(conn, "new_form.html")
    # end
    conn

    # case Experiment.create_task(current_experimenter, task_params) do
    #   {:ok, task} ->
    #     conn
    #     |> put_flash(:info, "Cognitive Bias Task created successfully.")
    #     |> redirect(to: Routes.task_path(conn, :new_form, task))

    #   {:error, %Ecto.Changeset{} = changeset} ->
    #     render(conn, "new_form.html", changeset: changeset)
    # end
  end

  def action(conn, _) do
    args = [conn, conn.params, conn.assigns.current_experimenter]
    apply(__MODULE__, action_name(conn), args)
  end
end
