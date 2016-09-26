defmodule Board do
  defstruct columns: nil, rows: nil, grid: nil

  def new(columns \\ 7, rows \\ 7) do
    grid = create_grid(%{}, columns, rows)
    %Board{columns: columns, rows: rows, grid: grid}
  end

  def to_string(board) do
    # String.duplicate("__", board.columns) <> "_"
    ""
    |> add_rows_to_string(board, board.rows)
    |> add_columns_to_string(board.columns)
  end

  defp add_rows_to_string(string, board, row) when row > 0 do
    string <> "|" <> Enum.reduce(1..board.columns, "", fn (col, str) ->
      str <> board.grid[col][row] <> "|"
    end) <> "\n"
    |> add_rows_to_string(board, row - 1)
  end
  defp add_rows_to_string(string, _board, _row), do: string

  defp add_columns_to_string(string, cols) do
    string <> " " <> Enum.join(1..cols, " ")
  end

  defp create_grid(grid, column, row) when column > 0 do
    rows = create_rows(%{}, row)
    grid
    |> Map.put(column, rows)
    |> create_grid(column - 1, row)
  end
  defp create_grid(grid, _column, _row), do: grid

  defp create_rows(map, row) when row > 0 do
    map
    |> Map.put(row, " ")
    |> create_rows(row - 1)
  end
  defp create_rows(map, _row), do: map
end
