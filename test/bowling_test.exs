defmodule BowlingTest do
  use ExUnit.Case

  test "roll a gutter game" do
    state = %Bowling{}

    new_state =
      Enum.reduce(1..20, state, fn _x, old_state ->
        Bowling.roll(old_state, 0)
      end)

    assert 0 == Bowling.score(new_state)
  end

  test "roll a game with only 1s" do
    state = %Bowling{}

    new_state =
      Enum.reduce(1..20, state, fn _x, old_state ->
        Bowling.roll(old_state, 1)
      end)

    assert 20 == Bowling.score(new_state)
  end
end
