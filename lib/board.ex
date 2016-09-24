defmodule Board do
  defstruct columns: nil, rows: nil, grid: nil

  def new(columns \\ 7, rows \\ 7) do
    %Board{columns: columns, rows: rows, grid: create_grid(columns, rows)}
  end

  def to_string(board) do
    "-"
    |> String.duplicate(board.columns)
    |> add_rows_to_string(board, board.rows)
  end

  defp add_rows_to_string(string, _board, row) when row == 0 do string end
  defp add_rows_to_string(string, board, row) do
    string <> "\n" <> row_to_string(board, row)
    |> add_rows_to_string(board, row - 1)
  end

  defp row_to_string(board, row) do
    "|" <> Enum.reduce(1..board.columns, "", fn (col, str) -> 
      str <> board.grid[col][row]
    end) <> "|"
  end

  defp create_grid(columns, rows), do: create_columns(%{}, columns, rows)

  defp create_columns(grid, column, _row) when column == 0 do grid end
  defp create_columns(grid, column, row) do
    rows = create_rows(%{}, row)
    grid
    |> Map.put(column, rows)
    |> create_columns(column - 1, row)
  end

  defp create_rows(map, row) when row == 0 do map end
  defp create_rows(map, row) do
    map
    |> Map.put(row, " ")
    |> create_rows(row - 1)
  end
end
