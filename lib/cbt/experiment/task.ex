defmodule Cbt.Experiment.Task do
  use Ecto.Schema
  import Ecto.Changeset

  schema "tasks" do
    field :name, :string
    field :url, :string

    belongs_to :experimenter, Cbt.Accounts.Experimenter

    timestamps()
  end

  @doc false
  def changeset(task, attrs) do
    task
    |> cast(attrs, [:name, :url])
    |> validate_required([:name, :url])
  end
end
