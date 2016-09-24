defmodule Debug do
  def print_game(game) do
    IO.puts("\nDEV***********************")
    IO.puts("The Game:")
    print_players(game)
    IO.puts(nil)
    print_board(game)
    IO.puts("***********************DEV\n")

    game
  end

  defp print_players(game) do
    IO.puts("Players:")
    Enum.each(game.players, fn player ->
      IO.puts(player)
    end)
    game
  end

  defp print_board(game) do
    IO.puts("Board:\n#{game.board}")
    game
  end
end
