defmodule ExMon do
  alias ExMon.{Game, Player}
  alias ExMon.Game.{Actions, Status}
  @computer_name "Robotinik"

  def create_player(name, move_avg, move_heal, move_rnd) do
    Player.build(name, move_avg, move_heal, move_rnd)
  end

  def start_game(player) do
    @computer_name
    |> create_player(:punch, :heal, :kick)
    |> Game.start(player)

    Status.print_round_message(Game.info())
  end

  def make_move(move) do
    move
    |> Actions.fetch_move()
    |> do_move()
  end

  defp do_move({:error, move}), do: Status.print_wrong_move_message(move)

  defp do_move({:ok, move}) do
    case move do
      :move_heal -> "realiza_cura"
      move -> Actions.attack(move)
    end

    Status.print_round_message(Game.info())
  end
end
