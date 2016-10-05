defmodule Board.Score do
  def full?(%Board{openings: 0}), do: true
  def full?(_), do: false

  def win?(%Board{openings: openings, cols: cols, rows: rows}, _, _, _)
  when openings > (cols * rows) - 7 do
    false
  end
  def win?(%Board{} = board, col, row, token) do
    vertical_win?(board, col, row, token)
    || horizontal_win?(board, col, row, token)
    || diagonal_win?(board, col, row, token)
    || antidiagonal_win?(board, col, row, token)
  end

  defp vertical_win?(%Board{}, _, row, _) when row < 4 do false end
  defp vertical_win?(%Board{} = board, col, row, token) do
    # Count down
    3 < count(1, board, col, row, 0, -1, token)
  end

  defp horizontal_win?(%Board{} = board, col, row, token) do
    1
    |> count(board, col, row, -1, 0, token) # Left
    |> count(board, col, row,  1, 0, token) # Right
    |> Kernel.>(3)
  end

  # "\" Diagonal
  defp diagonal_win?(%Board{} = board, col, row, token) do
    1
    |> count(board, col, row, -1,  1, token) # Up/Left
    |> count(board, col, row,  1, -1, token) # Down/Right
    |> Kernel.>(3)
  end

  # "/" Antidiagonal
  defp antidiagonal_win?(%Board{} = board, col, row, token) do
    1
    |> count(board, col, row, -1, -1, token) # Down/Left
    |> count(board, col, row,  1,  1, token) # Up/Right
    |> Kernel.>(3)
  end

  # Left boundary
  defp count(count, _board, 0, _row, _dx, _dy, _token), do: count

  # Bottom boundary
  defp count(count, _board, _col, 0, _dx, _dy, _token), do: count

  # Right boundary
  defp count(count, %Board{cols: cols}, col, _row, _dx, _dy, _token)
  when col > cols do count end

  # Top boundary
  defp count(count, %Board{rows: rows}, _col, row, _dx, _dy, _token)
  when row > rows do count end

  # Recursively count next adjacent if matches token
  defp count(count, %Board{} = board, col, row, dx, dy, token) do
    {c, r} = {col + dx, row + dy}
    cond do
      board.grid[c][r] == token ->
        count(count + 1, board, c, r, dx, dy, token)
      true ->
        count
    end
  end
end
