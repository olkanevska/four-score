defmodule Game do
  import Game.IO
  import Board.Scoring

  defstruct players: [], next_player: nil, board: nil, victor: nil

  @tokens [first: "X", second: "O"]

  def new, do: %Game{}

  def create_players(%Game{} = game) do
    players = Enum.map(@tokens, fn {ordinal, token} ->
      get_string("Enter #{ordinal} player name: ")
      |> Player.new(token)
    end)
    %Game{game | players: players, next_player: 0}
  end

  def create_board(%Game{} = game) do
    board = case get_num("\nUse (1) standard or (2) custom board: ", 1, 2) do
      1 -> Board.new
      _ ->
        cols = get_num("Number of columns (5-15): ", 5, 15)
        rows = get_num("Number of rows (5-15): ", 5, 15)
        Board.new(cols, rows)
    end
    %Game{game | board: board}
  end

  def loop(%Game{} = game) do
    IO.puts("\n#{game.board}\n")

    player = Enum.at(game.players, game.next_player)
    {board, col, row} = choose_col(game.board, player)

    game = %Game{game | board: board}

    cond do
      win?(board, col, row, player.token) ->
        %Game{game | victor: player}
      full?(board) ->
        game
      true ->
        loop(%Game{game | next_player: 1 - game.next_player})
    end
  end

  def finish(%Game{board: board, victor: victor}) do
    IO.puts("\n#{board}\n")
    case victor do
      %Player{} -> IO.puts("#{victor.name} won!")
      _ -> IO.puts("Draw.")
    end
  end

  defp choose_col(board, player) do
    col = get_num("#{player} - choose column: ", 1, board.cols)

    case Board.find_open_cell(board, col) do
      nil -> choose_col(board, player)
      row ->
        board = Board.add_piece(board, player.token, col, row)
        {board, col, row}
    end
  end
end
