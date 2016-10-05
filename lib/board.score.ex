defmodule Board.Score do
  def full?(%Board{openings: 0}), do: true
  def full?(_), do: false

  def win?(%Board{openings: openings, cols: cols, rows: rows}, _, _, _)
  when openings > (cols * rows) - 7 do
    false
  end
  def win?(%Board{} = board, col, row, token) do
    vertical?(board, col, row, token)   ||
    horizontal?(board, col, row, token) ||
    diagonal?(board, col, row, token)   ||
    antidiagonal?(board, col, row, token)
  end

  #
  # Individual direction checks
  #

  defp vertical?(%Board{}, _, row, _) when row < 4 do false end
  defp vertical?(%Board{} = board, col, row, token) do
    count_down(1, board, col, row, token) >= 4
  end

  defp horizontal?(%Board{} = board, col, row, token) do
    1
    |> count_left(board, col, row, token)
    |> count_right(board, col, row, token)
    |> Kernel.>=(4)
  end


  # "\" Diagonal
  defp diagonal?(%Board{} = board, col, row, token) do
    1
    |> count_up_left(board, col, row, token)
    |> count_down_right(board, col, row, token)
    |> Kernel.>=(4)
  end

  # "/" Antidiagonal
  defp antidiagonal?(%Board{} = board, col, row, token) do
    1
    |> count_down_left(board, col, row, token)
    |> count_up_right(board, col, row, token)
    |> Kernel.>=(4)
  end

  #
  # Recursively count the number of spaces in the given direction that match
  # the provided token and add that count to the initial given count,
  # stopping either when a boundary is hit or the token does not match
  #

  # Down - Check bottom boundary
  defp count_down(count, _, _, 0, _), do: count
  defp count_down(count, %Board{} = board, col, row, token) do
    # Decrement row
    {c, r} = {col, row - 1}
    cond do
      board.grid[c][r] == token -> count_down(count + 1, board, c, r, token)
      true -> count
    end
  end

  # Left - Check left boundary
  defp count_left(count, %Board{}, 0, _, _), do: count
  defp count_left(count, %Board{} = board, col, row, token) do
    # Decrement column
    {c, r} = {col - 1, row}
    cond do
      board.grid[c][r] == token -> count_left(count + 1, board, c, r, token)
      true -> count
    end
  end

  # Up/Left - Check left and top boundaries
  defp count_up_left(count, %Board{}, 0, _, _), do: count
  defp count_up_left(count, %Board{rows: rows}, _, row, _) when row > rows do
    count
  end
  defp count_up_left(count, %Board{} = board, col, row, token) do
    # Decrement column, increment row
    {c, r} = {col - 1, row + 1}
    cond do
      board.grid[c][r] == token -> count_up_left(count + 1, board, c, r, token)
      true -> count
    end
  end

  # Down/Left - Check left and bottom boundaries
  defp count_down_left(count, %Board{}, 0, _, _), do: count
  defp count_down_left(count, %Board{}, _, 0, _), do: count
  defp count_down_left(count, %Board{} = board, col, row, token) do
    # Decrement column, decrement row
    {c, r} = {col - 1, row - 1}
    cond do
      board.grid[c][r] == token -> count_down_left(count + 1, board, c, r, token)
      true -> count
    end
  end

  # Right - Check right boundary
  defp count_right(count, %Board{cols: cols}, col, _, _) when col > cols do
    count
  end
  defp count_right(count, %Board{} = board, col, row, token) do
    # Increment column
    {c, r} = {col + 1, row}
    cond do
      board.grid[c][r] == token -> count_right(count + 1, board, c, r, token)
      true -> count
    end
  end

  # Up/Right - Check top and right boundaries
  defp count_up_right(count, %Board{rows: rows}, _, row, _) when row > rows do
    count
  end
  defp count_up_right(count, %Board{cols: cols}, col, _, _) when col > cols do
    count
  end
  defp count_up_right(count, %Board{} = board, col, row, token) do
    # Increment column, increment row
    {c, r} = {col + 1, row + 1}
    cond do
      board.grid[c][r] == token -> count_up_right(count + 1, board, c, r, token)
      true -> count
    end
  end

  # Down/Right - Check bottom and right boundaries
  defp count_down_right(count, _, _, 0, _), do: count
  defp count_down_right(count, %Board{cols: cols}, col, _, _) when col > cols do
    count
  end
  defp count_down_right(count, %Board{} = board, col, row, token) do
    # Increment column, decrement row
    {c, r} = {col + 1, row - 1}
    cond do
      board.grid[c][r] == token -> count_down_right(count + 1, board, c, r, token)
      true -> count
    end
  end
end
