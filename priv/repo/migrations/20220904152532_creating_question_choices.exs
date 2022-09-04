defmodule Cbt.Repo.Migrations.CreatingQuestionChoices do
  use Ecto.Migration

  def change do
    create table(:question_choices) do
      add :text, :string
      add :question_id, references(:questions)
    end
  end
end
