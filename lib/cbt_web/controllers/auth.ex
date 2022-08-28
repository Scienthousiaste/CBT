defmodule CbtWeb.Auth do
  import Plug.Conn
  import Phoenix.Controller

  alias CbtWeb.Router.Helpers, as: Routes

  def init(opts), do: opts

  @spec call(Plug.Conn.t(), any) :: Plug.Conn.t()
  def call(conn, _opts) do
    experimenter_id = get_session(conn, :experimenter_id)
    experimenter = experimenter_id && Cbt.Accounts.get_experimenter(experimenter_id)
    assign(conn, :current_experimenter, experimenter)
  end

  def login(conn, experimenter) do
    conn
    |> assign(:current_experimenter, experimenter)
    |> put_session(:experimenter_id, experimenter.id)
    |> configure_session(renew: true)
  end

  def logout(conn) do
    configure_session(conn, drop: true)
  end

  def authenticate_experimenter(conn, _opts) do
    if conn.assigns.current_experimenter do
      conn
    else
      conn
      |> put_flash(:error, "You must be logged in to access that page")
      |> redirect(to: Routes.page_path(conn, :index))
      |> halt()
    end
  end
end
