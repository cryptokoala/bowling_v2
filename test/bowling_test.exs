defmodule Bowling do
  defstruct score: []

  def roll(%{score: score}, pin) do
    %{score: score ++ [pin]}
  end

  def score(%{score: score}) do
    Enum.reduce(1..10, 0, fn frame, acc_score ->
      first_pin_in_frame = Enum.fetch!(score, (frame - 1) * 2)
      second_pin_in_frame = Enum.fetch!(score, (frame - 1) * 2 + 1)

      if first_pin_in_frame + second_pin_in_frame == 10 do
        first_pin_in_next_frame = Enum.fetch!(score, frame * 2)
        acc_score + 10 + first_pin_in_next_frame
      else
        acc_score + first_pin_in_frame + second_pin_in_frame
      end
    end)
  end
end

defmodule BowlingTest do
  use ExUnit.Case

  setup do
    [state: %Bowling{}]
  end

  def roll_remaining_rolls(state, pin, rolls) do
    Enum.reduce(1..rolls, state, fn _x, old_state ->
      Bowling.roll(old_state, pin)
    end)
  end

  test "roll a gutter game", %{state: state} do
    new_state = roll_remaining_rolls(state, 0, 20)
    assert 0 == Bowling.score(new_state)
  end

  test "roll a game with only 1s", %{state: state} do
    new_state = roll_remaining_rolls(state, 1, 20)
    assert 20 == Bowling.score(new_state)
  end

  test "roll a spare and a single roll of 3, should get 16", %{state: state} do
    state = Bowling.roll(state, 5)
    state = Bowling.roll(state, 5)
    state = Bowling.roll(state, 3)
    state = roll_remaining_rolls(state, 0, 17)

    assert 16 == Bowling.score(state)
  end
end
