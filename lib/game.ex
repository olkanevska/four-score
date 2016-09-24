defmodule Game do
  import Game.IO

  defstruct players: [], board: nil

  @tokens [first: "O", second: "X"]

  def new, do: %Game{}

  def create_players(game) do
    players = Enum.map(@tokens, fn {ordinal, token} ->
      get_string("Enter #{ordinal} player name: ")
      |> Player.new(token)
    end)
    %Game{game | players: players}
  end

  def create_board(game) do
    board = case get_num("\nUse (1) standard or (2) custom board: ", 1, 2) do
      1 ->
        Board.new
      _ ->
        columns = get_num("Number of columns (4-16): ", 4, 16)
        rows = get_num("Number of rows (4-16): ", 4, 16)
        Board.new(columns, rows)
    end
    %Game{game | board: board}
  end
end
