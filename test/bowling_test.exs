defmodule BowlingTest do
  use ExUnit.Case

  setup do
    [state: %Bowling{}]
  end

  def roll_remaining_rolls(state, pin) do
    Enum.reduce(1..20, state, fn _x, old_state ->
      Bowling.roll(old_state, pin)
    end)
  end

  test "roll a gutter game", %{state: state} do
    new_state = roll_remaining_rolls(state, 0)
    assert 0 == Bowling.score(new_state)
  end

  test "roll a game with only 1s", %{state: state} do
    new_state = roll_remaining_rolls(state, 1)
    assert 20 == Bowling.score(new_state)
  end
end
