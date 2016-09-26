defmodule Board do
  defstruct columns: nil, rows: nil, grid: nil

  def new(columns \\ 7, rows \\ 7) do
    %Board{columns: columns, rows: rows, grid: create_grid(columns, rows)}
  end

  def to_string(board) do
    # String.duplicate("__", board.columns) <> "_" |>
    ""
    |> add_rows_to_string(board, board.rows)
    |> add_columns_to_string(board.columns)
  end

  defp add_rows_to_string(string, board, row) when row > 0 do
    string <> row_to_string(board, row)
    |> add_rows_to_string(board, row - 1)
  end
  defp add_rows_to_string(string, _board, _row), do: string

  defp row_to_string(board, row) do
    "|" <> Enum.reduce(1..board.columns, "", fn (col, str) -> 
      str <> board.grid[col][row] <> "|"
    end) <> "\n"
  end

  defp add_columns_to_string(string, cols) do
    string <> " " <> Enum.join(1..cols, " ")
  end

  defp create_grid(columns, rows), do: create_columns(%{}, columns, rows)

  defp create_columns(grid, column, row) when column > 0 do
    rows = create_rows(%{}, row)
    grid
    |> Map.put(column, rows)
    |> create_columns(column - 1, row)
  end
  defp create_columns(grid, _column, _row), do: grid

  defp create_rows(map, row) when row > 0 do
    map
    |> Map.put(row, "X")
    |> create_rows(row - 1)
  end
  defp create_rows(map, _row), do: map
end
