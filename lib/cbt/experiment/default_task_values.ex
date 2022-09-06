defmodule Cbt.Experiment.DefaultTaskValues do
  def pre_form_instruction do
    "Hello,

Thanks for taking part of this experiment. It should take around 10 minutes to complete. Please make sure you will not be distracted during that time, and to complete the experiment in a single session.

Before you start the experiment itself, you will be asked a few questions in the next page. The information collected is anonymous and for the exclusive use of the researchers involved in the study."
  end

  def pre_expe_instruction do
    "Now, you will see cards with different designs. The designs may vary in several respects. You will see a card at the top and two cards below. Look at the top card and choose one of the two cards below that you like the best. There are no \"correct\" or \"incorrect\" responses. Your choice is entirely up to you. Please, try to choose quickly."
  end

  def end_instruction do
    "The experiment is over. Thanks a lot for your participation."
  end
end
