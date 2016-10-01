defmodule Game do
  import Game.IO

  defstruct players: [], next_player: nil, board: nil, victor: nil

  @tokens [first: "X", second: "O"]

  def new, do: %Game{}

  def create_players(game) do
    players = Enum.map(@tokens, fn {ordinal, token} ->
      get_string("Enter #{ordinal} player name: ")
      |> Player.new(token)
    end)
    %Game{game | players: players, next_player: 0}
  end

  def create_board(game) do
    board = case get_num("\nUse (1) standard or (2) custom board: ", 1, 2) do
      1 -> Board.new
      _ ->
        cols = get_num("Number of columns (5-15): ", 5, 15)
        rows = get_num("Number of rows (5-15): ", 5, 15)
        Board.new(cols, rows)
    end
    %Game{game | board: board}
  end

  def loop(game) do
    IO.puts("\n#{game.board}\n")

    player = Enum.at(game.players, game.next_player)
    {board, col, row} = choose_col(game.board, player)

    case check_for_win(board, col, row, player.token) do
      :true -> %Game{game | victor: player}
      :draw -> game
      {:ok, board} ->
        loop(%Game{game | board: board, next_player: 1 - game.next_player})
    end
  end

  def finish(%Game{victor: victor}) when victor do nil end
  def finish(_game), do: nil

  defp choose_col(board, player) do
    col = get_num("#{player.name}, choose column: ", 1, board.cols)

    case Board.find_open_cell(board, col) do
      nil -> choose_col(board, player)
      row ->
        board = Board.add_piece(board, player.token, col, row)
        {board, col, row}
    end
  end

  defp check_for_win(board, col, row, token) do
    check_vertical(board, col, row, token)   ||
    check_horizontal(board, col, row, token) ||
    check_diagonal(board, col, row, token)   ||
    check_antidiagonal(board, col, row, token) ||
    {:ok, board}
  end

  defp check_vertical(_, _, row, _) when row < 4 do false end
  defp check_vertical(%Board{rows: rows} = board, col, row, token) do
    1 |> check_down(board, col, row, token)
    # row - 3..row
    # |> Enum.reduce("", fn (y, str) -> str <> board.grid[col][y] end)
    # |> String.contains?(String.duplicate(token, 4))
  end

  defp check_down(counter, _board, _col, row) when row == 0 do counter end
  defp check_down(counter, board, col, row)

  defp check_horizontal(%Board{cols: cols} = board, col, row, token) do
    position_range(col, cols)
    |> Enum.reduce("", fn (x, str) -> str <> board.grid[x][row] end)
    |> String.contains?(String.duplicate(token, 4))
  end

  # "\" Diagonal
  defp check_diagonal(_, _, row, _) when row < 4 do false end
  defp check_diagonal(%Board{rows: rows} = board, col, row, token) do
  end

  # "/" Antidiagonal
  defp check_antidiagonal(_, _, row, _) when row < 4 do false end
  defp check_antidiagonal(%Board{rows: rows} = board, col, row, token) do
  end

  defp position_range(pos, total), do: min_pos(pos)..max_pos(pos, total)
  defp min_pos(pos) when pos > 3 do pos - 3 end
  defp min_pos(pos) when pos <= 3 do 1 end
  defp max_pos(pos, total) when pos < total - 2 do pos + 3 end
  defp max_pos(pos, total) when pos >= total - 2 do total end
end
