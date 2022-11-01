defmodule Cbt.AccessControl.AccessAndAssignExperiment do
  import Phoenix.Controller
  import Plug.Conn

  alias Cbt.Experiment
  alias Cbt.Experiment.Task
  alias Cbt.Utils
  alias Plug.Conn

  def init(options), do: options

  def call(%Conn{assigns: %{current_experimenter: current_experimenter}, params: %{"id" => raw_task_id}} = conn, _) do
    task_id = Utils.parse_id(raw_task_id)

    case task_id && Experiment.get_experimenter_task!(current_experimenter, task_id) do
      %Task{} = task ->
        assign(conn, :task, task)

      _ ->
        conn
        |> put_status(:not_found)
        |> put_layout(false)
        |> halt()
        # Utils.halt_not_found(conn, message: "Unknown task"), redirect: Routes.training_session_path(conn, :index))
    end
  end

  # def call(%Conn{} = conn, _) do
  #   Logger.error("Attempt to check access without trainee id")
  #   ConnUtils.halt_bad_request(conn)
  # end
end
