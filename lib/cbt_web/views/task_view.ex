defmodule CbtWeb.TaskView do
  use CbtWeb, :view

  alias Cbt.Experiment.DefaultTaskValues
  alias Cbt.Experiment.Question

  def default_pre_form_instruction do
    DefaultTaskValues.pre_form_instruction()
  end

  def default_pre_expe_instruction do
    DefaultTaskValues.pre_expe_instruction()
  end

  def default_end_instruction do
    DefaultTaskValues.end_instruction()
  end

  defp show_question_content(%{data: %Question{type_answer: :unique_choice}} = assigns) do
    ~H"""
      <%= select_answer_type(assigns) %>
      <%= for choice <- @data.choices do %>
          <%= text_input assigns, :choices, value: choice.text %>
      <% end %>
      <div>+</div>
    """
  end

  defp show_question_content(%{data: %Question{type_answer: :multiple_choice}} = assigns) do
    ~H"""
      <div class="question-content">
        <%= for choice <- @data.choices do %>
          <div class="user-choice">
            <input type="text" value={choice}>
            <button class="button remove-button">-</button>
          </div>
        <% end %>
        <button class="button add-choice-button">Add choice +</button>
      </div>
    """
  end

  defp show_question_content(%{data: %Question{type_answer: :number}} = assigns) do
    ~H"""
      <%= select_answer_type(assigns) %>
    """
  end

  defp show_question_content(%{data: %Question{type_answer: :integer}} = assigns) do
    ~H"""
      <%= select_answer_type(assigns) %>
    """
  end

  defp show_question_content(%{data: %Question{type_answer: :boolean}} = assigns) do
    ~H"""
      <%= select_answer_type(assigns) %>
    """
  end

  defp show_question_content(%{data: %Question{type_answer: :text}} = assigns) do
    ~H"""
      <%= select_answer_type(assigns) %>
    """
  end

  defp select_answer_type(assigns) do
    ~H"""
    <%= select(assigns, :type_answer, [
      {"Single choice", :unique_choice},
      {"Multiple choice", :multiple_choice},
      {"Number", :number},
      {"True/False", :boolean},
      {"Text", :text},
      {"Integer", :integer}
      ],

      selected: @data.type_answer)
    %>
    """
  end
end
