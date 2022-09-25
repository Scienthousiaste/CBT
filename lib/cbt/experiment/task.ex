defmodule Cbt.Experiment.Task do
  use Ecto.Schema
  import Ecto.Changeset

  alias Cbt.Experiment.DefaultQuestions
  alias Cbt.Experiment.Question

  schema "tasks" do
    field :name, :string
    field :url, :string
    field :language, :string
    field :pre_form_instruction, :string
    field :pre_expe_instruction, :string
    field :end_instruction, :string
    field :description, :string

    belongs_to :experimenter, Cbt.Accounts.Experimenter

    embeds_many :questions, Question, on_replace: :delete
    timestamps()
  end

  @attributes [
    :name,
    :url,
    :language,
    :pre_form_instruction,
    :pre_expe_instruction,
    :end_instruction,
    :description
  ]

  @required_attributes [:name, :pre_form_instruction, :pre_expe_instruction, :end_instruction]

  def changeset(task, attrs) do
    task
    |> cast(attrs, @attributes)
    |> cast_embed(:questions, with: &Question.changeset/2)
    |> validate_required(@required_attributes)
  end

  def init_changeset(task, attrs) do
    default_questions = DefaultQuestions.get_default_questions()

    task
    |> cast(attrs, @attributes)
    |> put_embed(:questions, default_questions)
    |> validate_required(@required_attributes)
  end
end
