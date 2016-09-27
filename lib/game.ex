defmodule Game do
  import Game.IO

  defstruct players: [], next_player: nil, board: nil, victor: nil

  @tokens [first: "O", second: "X"]

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
        columns = get_num("Number of columns (4-16): ", 4, 16)
        rows = get_num("Number of rows (4-16): ", 4, 16)
        Board.new(columns, rows)
    end
    %Game{game | board: board}
  end

  def loop(game) do
    IO.puts("\n#{game.board}\n")
    {board, col, row} = choose_column(game)

    case check_for_win(board, col, row) do
      {:win, player} -> %Game{game | victor: player}
      {:draw}        -> game
      {:ok, board}   ->
        loop(%Game{game | board: board, next_player: 1 - game.next_player})
    end
  end

  def finish(%Game{victor: victor}) when victor do nil end
  def finish(_game), do: nil

  defp choose_column(game) do
    player = Enum.at(game.players, game.next_player)

    col ="#{player.name}, choose column: "
    |> get_num(1, game.board.columns)

    case Board.find_open_cell(game.board, col) do
      nil -> choose_column(game)
      row ->
        board = Board.add_piece(game.board, player.token, col, row)
        print_board(board)
        {board, col, row}
    end
  end

  defp print_board(board) do
    IO.puts("\n#{board}\n")
  end

  defp check_for_win(board, column, row) do
    # check_vertical(board, column, row) ||
    # check_first_diagonal(board, column, row) ||
    # check_second_diagonal(board, column, row)
    {:ok, board}
  end

  defp check_vertical(_board, _column, row) when row < 4 do false end
  defp check_vertical(%Board{grid: grid}, column, row) do
  end
end
