defmodule Board do
  defstruct cols: nil, rows: nil, grid: nil, openings: nil

  def new(cols \\ 7, rows \\ 7) do
    grid = create_grid(%{}, cols, rows)
    %Board{grid: grid, cols: cols, rows: rows, openings: cols * rows}
  end

  def add_piece(%Board{grid: grid, openings: openings} = board, token, col, row) do
    new_row_map = Map.put(grid[col], row, token)
    new_grid = Map.put(grid, col, new_row_map)
    %Board{board | grid: new_grid, openings: openings - 1}
  end

  def find_open_cell(%Board{cols: cols} = board, col) when col in 1..cols do
    Enum.find 1..board.rows, fn row ->
      board.grid[col][row] == " "
    end
  end

  def to_string(board) do
    "" # String.duplicate("__", board.cols) <> "_"
    |> add_rows_to_string(board, board.rows)
    |> add_cols_to_string(board.cols)
  end

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

  defp create_grid(grid, col, row) when col > 0 do
    rows = create_rows(%{}, row)
    grid
    |> Map.put(col, rows)
    |> create_grid(col - 1, row)
  end
  defp create_grid(grid, _col, _row), do: grid

  defp create_rows(map, row) when row > 0 do
    map
    |> Map.put(row, " ")
    |> create_rows(row - 1)
  end
  defp create_rows(map, _row), do: map
end
