defmodule Board.Score do
  def full?(%Board{} = board), do: board.pieces >= board.rows * board.cols

  def win?(%Board{pieces: pieces} = board, col, row, token)
  when pieces > 6 do
    vertical_win?(board, col, row, token)
    || horizontal_win?(board, col, row, token)
    || diagonal_win?(board, col, row, token)
    || antidiagonal_win?(board, col, row, token)
  end
  def win?(%Board{}, _col, _row, _token), do: false

  defp vertical_win?(%Board{} = board, col, row, token)
  when row > 3 do
    count(1, board, col, row, 0, -1, token) > 3 # Down
  end
  defp vertical_win?(%Board{}, _col, _row, _token), do: false

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
    case board.grid[c][r] == token do
      true  -> count(count + 1, board, c, r, dx, dy, token)
      false -> count
    end
  end
end
