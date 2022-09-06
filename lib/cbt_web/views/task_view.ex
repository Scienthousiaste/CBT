defmodule CbtWeb.TaskView do
  use CbtWeb, :view

  alias Cbt.Experiment.DefaultTaskValues

  def default_pre_form_instruction do
    DefaultTaskValues.pre_form_instruction()
  end

  def default_pre_expe_instruction do
    DefaultTaskValues.pre_expe_instruction()
  end

  def default_end_instruction do
    DefaultTaskValues.end_instruction()
  end
end
