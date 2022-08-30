defmodule Cbt.Repo.Migrations.AddingInstructionsAndLanguageToTasks do
  use Ecto.Migration

  def change do
    alter table(:tasks) do
      add :language, :string
      add :pre_form_instruction, :string
      add :pre_expe_instruction, :string
      add :end_instruction, :string
      add :description, :string
    end
  end
end
