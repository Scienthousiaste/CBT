defmodule Cbt.Repo.Migrations.CreateQuestions do
  use Ecto.Migration

  def change do
    create table(:questions) do
      add :is_default, :boolean, default: false, null: false
      add :text, :string
      add :type_answer, :string
      add :task_id, references(:tasks)

      timestamps()
    end
  end
end
