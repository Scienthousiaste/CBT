defmodule CbtWeb.PageController do
  use CbtWeb, :controller

  def index(conn, _params) do
    data = %{
      contact_email: "tbehra.dev@gmail.com"
    }
    render(conn, "index.html", data)
  end
end
