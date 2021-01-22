defmodule ExMonTest do
  use ExUnit.Case
  import ExUnit.CaptureIO

  alias ExMon.Player

  describe "create_player/4" do
    test "returns a player" do
      expected_response = %Player{
        life: 100,
        moves: %{move_avg: :chute, move_heal: :cura, move_rnd: :soco},
        name: "Guilherme"
      }

      assert expected_response == ExMon.create_player("Guilherme", :chute, :cura, :soco)
    end
  end

  describe "start_game/1" do
    test "when the game started, returns a message" do
      player = Player.build("Guilherme", :chute, :cura, :soco)

      messages = capture_io(fn ->
        assert ExMon.start_game(player) == :ok
      end)

      assert messages =~ "The game is started"
      assert messages =~ "status: :started"
      assert messages =~ "turn: :player"
    end
  end
end
