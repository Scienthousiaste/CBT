defmodule Cbt.Experiment.Task do
  use Ecto.Schema
  import Ecto.Changeset

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

    embeds_many :questions, Question
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
    |> validate_required(@required_attributes)
    |> cast_embed(:questions, with: &Question.changeset/2)
  end
end
