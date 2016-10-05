defmodule Board do
  defstruct cols: nil, rows: nil, grid: nil, openings: nil

  def new(cols \\ 7, rows \\ 7) do
    %Board{
      grid: %{} |> add_columns(cols, rows),
      openings: cols * rows,
      cols: cols,
      rows: rows
    }
  end

  def add_piece(%Board{grid: grid} = board, col, row, token) do
    %Board{board |
      grid: put_in(grid[col][row], token),
      openings: board.openings - 1
    }
  end

  def find_open_cell(%Board{cols: cols} = board, col) when col in 1..cols do
    Enum.find(1..board.rows, &(board.grid[col][&1] == " "))
  end

  def to_string(%Board{} = board) do
    "" # String.duplicate("__", board.cols) <> "_"
    |> add_rows_to_string(board, board.rows)
    |> add_cols_to_string(board.cols)
  end

  #
  # Board.new helpers
  #

  defp add_columns(grid, col, row) when col > 0 do
    rows = add_rows(%{}, row)
    grid
    |> Map.put(col, rows)
    |> add_columns(col - 1, row)
  end
  defp add_columns(grid, _col, _row), do: grid

  defp add_rows(map, row) when row > 0 do
    map
    |> Map.put(row, " ")
    |> add_rows(row - 1)
  end
  defp add_rows(map, _row), do: map

  #
  # Board.to_string helpers
  #

  defp add_rows_to_string(string, board, row) when row > 0 do
    string <> row_to_string(board, row)
    |> add_rows_to_string(board, row - 1)
  end
  defp add_rows_to_string(string, _board, _row), do: string

  defp row_to_string(board, row) do
    Enum.reduce(1..board.cols, "", fn (col, str) ->
      str <> "|" <> board.grid[col][row]
    end) <> "|\n"
  end

  defp add_cols_to_string(string, cols) do
    string <> " " <> Enum.join(1..cols, " ")
  end
end
