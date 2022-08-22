defmodule CbtWeb.SessionController do
  use CbtWeb, :controller

  def new(conn, _) do
    render(conn, "new.html")
  end

  def create(conn, %{"session" => %{"email" => email, "password" => password}}) do
    case Cbt.Accounts.authenticate_by_email_and_pass(email, password) do
      {:ok, experimenter} ->
        conn
        |> CbtWeb.Auth.login(experimenter)
        |> put_flash(:info, "Welcome back!")
        |> redirect(to: Routes.page_path(conn, :index))

      {:error, _reason} ->
        conn
        |> put_flash(:error, "Invalid username/password combination")
        |> render("new.html")
    end
  end
end
