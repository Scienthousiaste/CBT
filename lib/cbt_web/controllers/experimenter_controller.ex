defmodule CbtWeb.ExperimenterController do
  use CbtWeb, :controller

  alias Cbt.Accounts
  alias Cbt.Accounts.Experimenter

  def index(conn, _params) do
    render(conn, "index.html", experimenters: Accounts.list_experimenters())
  end

  def show(conn, %{"id" => id}) do
    experimenter = Accounts.get_experimenter(id)
    render(conn, "show.html", experimenter: experimenter)
  end

  def new(conn, _params) do
    changeset = Accounts.change_registration(%Experimenter{}, %{})
    require IEx; IEx.pry
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"experimenter" => experimenter_params}) do
    case Accounts.register_experimenter(experimenter_params) do
      {:ok, experimenter} ->
        conn
        |> put_flash(:info, "#{CbtWeb.ExperimenterView.full_name(experimenter)} created!")
        |> redirect(to: Routes.experimenter_path(conn, :index))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end
end
