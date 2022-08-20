defmodule Cbt.Accounts do
  alias Cbt.Accounts.Experimenter
  alias Cbt.Repo

  def get_experimenter(id) do
    Repo.get(Experimenter, id)
  end

  def get_experimenter_by(params) do
    Repo.get_by(Experimenter, params)
  end

  def list_experimenters() do
    Repo.all(Experimenter)
  end

  def change_experimenter(%Experimenter{} = experimenter) do
    Experimenter.changeset(experimenter, %{})
  end

  def create_experimenter(attrs \\ %{}) do
    %Experimenter{}
    |> Experimenter.changeset(attrs)
    |> Repo.insert()
  end

  def change_registration(%Experimenter{} = experimenter, params) do
    Experimenter.registration_changeset(experimenter, params)
  end

  def register_experimenter(attrs \\ %{}) do
    %Experimenter{}
    |> Experimenter.registration_changeset(attrs)
    |> Repo.insert()
  end
end
