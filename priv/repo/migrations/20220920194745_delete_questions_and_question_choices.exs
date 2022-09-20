defmodule Cbt.Repo.Migrations.DeleteQuestionsAndQuestionChoices do
  use Ecto.Migration

  def change do
    drop table(:question_choices)
    drop table(:questions)
  end
end
