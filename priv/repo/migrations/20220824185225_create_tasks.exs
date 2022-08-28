defmodule Cbt.Repo.Migrations.CreateTasks do
  use Ecto.Migration

  def change do
    create table(:tasks) do
      add :name, :string
      add :url, :string
      add :experimenter_id, references(:experimenters, on_delete: :nothing)

      timestamps()
    end

    create index(:tasks, [:experimenter_id])
  end
end
