defmodule Board do
  defstruct rows: nil, columns: nil, grid: nil

  def new do
    new(rows: 7, columns: 7)
  end

  def new(rows: rows, columns: columns) do
    %Board{
      rows: rows,
      columns: columns,
      grid: create_grid(rows, columns)
    }
  end

  # def to_string(board) do
    # Enum.map(1..5, fn _row ->
      # "board row\n"
    # end)
  # end

  defp create_grid(rows, columns) do
    %{} |> create_columns(rows, columns)
  end

  defp create_columns(grid, row, column) when column == 0 do
    grid
  end

  defp create_columns(grid, rows, column) do
    grid
    |> Map.put(column, create_rows(%{}, rows))
    |> create_columns(rows, column - 1)
  end

  defp create_rows(map, row) when row == 0 do
    map
  end

  defp create_rows(map, row) do
    map
    |> Map.put(row, "X")
    |> create_rows(row - 1)
  end
end
