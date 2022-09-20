defmodule Cbt.Repo.Migrations.EmbedQuestionsIntoTasks do
  use Ecto.Migration

  def change do
    alter table("tasks") do
      add :questions, :map
    end
  end
end
