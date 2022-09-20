defmodule Cbt.Experiment.Question do
  use Ecto.Schema
  import Ecto.Changeset


  embedded_schema do
    field :is_default, :boolean, default: false
    field :text, :string
    field :choices, {:array, :string}
    field :type_answer, Ecto.Enum,
      values: [:unique_choice, :multiple_choice, :number, :boolean, :text, :integer]

    belongs_to :task, Cbt.Experiment.Task

    timestamps()
  end

  @doc false
  def changeset(question, attrs) do
    question
    |> cast(attrs, [:is_default, :text, :type_answer, :task_id])
    |> validate_required([:is_default, :text, :type_answer, :task_id])
  end
end
