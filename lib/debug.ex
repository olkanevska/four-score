defmodule Debug do
  def print_game(game) do
    IO.puts("\nDEV***********************")
    IO.puts("The Game:")
    print_players(game)
    IO.puts(nil)
    # print_board(game)
    IO.puts("***********************DEV\n")

    game
  end

  defp print_players(game) do
    IO.puts("Here are the current players:")
    Enum.each(game.players, fn player ->
      player |> Player.to_string |> IO.puts
    end)
    game
  end

  defp print_board(game) do
    IO.puts("Here is the current board:")
    game.board |> Board.to_string |> IO.puts
    game
  end
end
