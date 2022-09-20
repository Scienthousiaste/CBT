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

  def display_question(assigns) do
    # <%# __meta__: #Ecto.Schema.Metadata<:loaded, "questions">,
    # id: 4,
    # choices: #Ecto.Association.NotLoaded<association :choices is not loaded>,
    # task: #Ecto.Association.NotLoaded<association :task is not loaded>,
    # task_id: 16,
    # text: "Years of education",
    # type_answer: :integer,
    # updated_at: ~N[2022-09-04 15:43:01] %>
    ~H"""
      <div class="question" id={"\"#{@question.id}\""}>
        <span class="remove-question">x</span>
        <%= text_input @form, :text, value: @question.text %>
        <%= show_question_content(assigns) %>
      </div>
    """
  end

  defp show_question_content(%{question: %Question{type_answer: :unique_choice}} = assigns) do
    ~H"""
      <%= select_answer_type(assigns) %>
      <%= for choice <- @question.choices do %>
          <div><%= choice.text %></div>
      <% end %>
    """
  end

  defp show_question_content(%{question: %Question{type_answer: :multiple_choice}} = assigns) do
    ~H"""
      <%= select_answer_type(assigns) %>
      <%= for choice <- @question.choices do %>
          <div><%= choice %></div>
      <% end %>
    """
  end

  defp show_question_content(%{question: %Question{type_answer: :number}} = assigns) do
    ~H"""
      <%= select_answer_type(assigns) %>
    """
  end

  defp show_question_content(%{question: %Question{type_answer: :integer}} = assigns) do
    ~H"""
      <%= select_answer_type(assigns) %>
    """
  end

  defp show_question_content(%{question: %Question{type_answer: :boolean}} = assigns) do
    ~H"""
      <%= select_answer_type(assigns) %>
    """
  end

  defp show_question_content(%{question: %Question{type_answer: :text}} = assigns) do
    ~H"""
      <%= select_answer_type(assigns) %>
    """
  end

  defp select_answer_type(%{question: %Question{type_answer: current_type}, form: f} = assigns) do
    ~H"""
      <%= select(f, :type_answer, [
        {"Single choice", :unique_choice},
        {"Multiple choice", :multiple_choice},
        {"Number", :number},
        {"True/False", :boolean},
        {"Text", :text},
        {"Integer", :integer}
        ],

        selected: current_type)
      %>
    """
  end

  # defp show_question_content(%Question{type_answer: :multiple_choice} = assigns) do
  #   ~H"""

  #   <%= select(form, field, options, opts \\ []) %>

  #   <%= for choice <- @choices do %>
  #       <div><%= choice.text %></div>
  #   <% end %>
  #   """
  # end
end
