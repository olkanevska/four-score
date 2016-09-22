defmodule Game do
  def play do
    IO.puts("\nWelcome to Fourscore!\n")

    Fourscore.new
    |> Fourscore.create_players
    |> Fourscore.create_board
    |> print_fourscore
  end

  # DEBUG FUNCTIONS

  defp print_fourscore(fourscore) do
    IO.puts("\nDEV***********************")
    IO.puts("The Fourscore:")
    print_players(fourscore)
    IO.puts(nil)
    # print_board(fourscore)
    IO.puts("***********************DEV\n")

    fourscore
  end

  defp print_players(fourscore) do
    IO.puts("Here are the current players:")
    Enum.each(fourscore.players, fn player ->
      player |> Player.to_string |> IO.puts
    end)
    fourscore
  end

  defp print_board(fourscore) do
    IO.puts("Here is the current board:")
    fourscore.board |> Board.to_string |> IO.puts
    fourscore
  end
end
