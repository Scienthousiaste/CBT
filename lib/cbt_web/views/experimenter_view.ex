defmodule CbtWeb.ExperimenterView do
  use CbtWeb, :view

  alias Cbt.Accounts

  def full_name(%Accounts.Experimenter{firstname: firstname, lastname: lastname}) do
    "#{firstname} #{lastname}"
  end
end
