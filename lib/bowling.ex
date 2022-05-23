defmodule Bowling do
  defstruct score: 0

  def roll(old_state, pin) do
    %{score: old_state.score + pin}
  end

  def score(new_state) do
    new_state.score
  end
end
