defmodule BowlingGame do
  defstruct pins: []

  def new do
    %__MODULE__{}
  end

  def roll(%__MODULE__{pins: pins}, pin) do
    %__MODULE__{pins: pins ++ [pin]}
  end

  def score(%__MODULE__{}) do
    0
  end
end

defmodule BowlingGameTest do
  use ExUnit.Case

  setup do
    [game: BowlingGame.new()]
  end

  def roll_game_with_pins(game, roll_times, pin) do
    Enum.reduce(1..roll_times, game, fn _i, acc_state ->
      acc_state |> BowlingGame.roll(pin)
    end)
  end

  def roll_gutter_game(game) do
    roll_game_with_pins(game, 20, 0)
  end

  describe "roll game" do
    test "new game", %{game: game} do
      # ram, not in disk, not in databa
      assert game == %BowlingGame{}
    end

    test "roll 0", %{game: game} do
      new_game = BowlingGame.roll(game, 0)
      assert [0] == new_game.pins
    end

    test "roll 1", %{game: game} do
      new_game = BowlingGame.roll(game, 1)
      assert [1] == new_game.pins
    end

    test "roll two 0-score pins in 1st frame", %{game: game} do
      new_game =
        game
        |> BowlingGame.roll(0)
        |> BowlingGame.roll(0)

      assert [0, 0] == new_game.pins
    end
  end

  describe "compute score" do
    test "new game", %{game: game} do
      assert 0 == BowlingGame.score(game)
    end
  end

  describe "gutter game" do
    setup %{game: game} do
      [game: roll_gutter_game(game)]
    end

    test "pins schema", %{game: game} do
      assert List.duplicate(0, 20) == game.pins
    end

    test "score/1", %{game: game} do
      assert 0 == BowlingGame.score(game)
    end
  end

  describe "1st frame 2, 3, other frames 0, 0" do
    setup %{game: game} do
      new_game = game |> BowlingGame.roll(2)
      new_game = new_game |> BowlingGame.roll(3)
      new_game = roll_game_with_pins(new_game, 18, 0)
      [game: new_game]
    end

    test "pins schema", %{game: game} do
      assert [2, 3] ++ List.duplicate(0, 18) == game.pins
    end

    # test "score with 5", %{game: game} do
    #  assert 5 == BowlingGame.score(game)
    # end
  end
end
