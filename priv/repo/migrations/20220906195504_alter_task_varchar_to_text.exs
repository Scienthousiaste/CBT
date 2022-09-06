defmodule Cbt.Repo.Migrations.AlterTaskVarcharToText do
  use Ecto.Migration

  def change do
    alter table(:tasks) do
      modify :pre_form_instruction, :text
      modify :pre_expe_instruction, :text
      modify :end_instruction, :text
      modify :description, :text
    end
  end
end
