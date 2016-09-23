defmodule Fourscore do
  def play do
    IO.puts("\nWelcome to Fourscore!\n")

    Game.new
    |> Game.create_players
    |> Game.create_board
    |> Debug.print_game
  end
end
