defmodule Cbt.Repo.Migrations.CreateExperimenters do
  use Ecto.Migration

  def change do
    create table(:experimenters) do
      add :firstname, :string
      add :lastname, :string, null: false
      add :email, :string, null: false
      add :is_admin, :boolean
      add :password_hash, :string

      timestamps()
    end

    create unique_index(:experimenters, [:email])
  end
end
