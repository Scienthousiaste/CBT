defmodule CbtWeb.CbtController do
  use CbtWeb, :controller

  # TODO
  # access and assign cbt task !!
  # plug :authenticate_subject

  def new_cbt(conn, %{"expe_string" => exp_string}) do
    render(conn, "new_cbt.html")
  end

end
