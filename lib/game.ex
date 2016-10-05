defmodule Game do
  alias Game.UI, as: UI
  alias Board.Score, as: Score

  defstruct players: [], next_player: nil, board: nil, victor: nil

  @tokens [first: "X", second: "O"]

  def new, do: %Game{}

  def create_players(%Game{} = game) do
    players = Enum.map(@tokens, fn {ordinal, token} ->
      "Enter #{ordinal} player name: "
      |> UI.get_string
      |> Player.new(token)
    end)
    %Game{game | players: players, next_player: 0}
  end

  def create_board(%Game{} = game) do
    case "Use (1) standard or (2) custom board: " |> UI.get_num(1, 2) do
      1 ->
        %Game{game | board: Board.new}
      2 ->
        cols = "Number of columns (5-15): " |> UI.get_num(5, 15)
        rows = "Number of rows (5-15): "    |> UI.get_num(5, 15)
        %Game{game | board: Board.new(cols, rows)}
      _ ->
        create_board(game)
    end
  end

  def loop(%Game{board: %Board{} = board, next_player: next} = game) do
    player = Enum.at(game.players, next)

    print_board(board)
    {new_board, col, row} = choose_col(board, player)
    updated_game = %Game{game | board: new_board}

    cond do
      Score.win?(new_board, col, row, player.token) ->
        %Game{updated_game | victor: player}
      Score.full?(board) ->
        updated_game
      true ->
        loop(%Game{updated_game | next_player: 1 - next})
    end
  end

  def finish(%Game{board: board, victor: victor}) do
    print_board(board)
    case victor do
      %Player{} ->
        IO.puts("#{victor.name} won!")
      _ ->
        IO.puts("Draw.")
    end
  end

  defp print_board(%Board{} = board), do: IO.puts("\n#{board}\n")

  defp choose_col(board, player) do
    col = "#{player} - choose column: " |> UI.get_num(1, board.cols)

    case Board.find_open_cell(board, col) do
      nil ->
        choose_col(board, player)
      row ->
        board = Board.add_piece(board, player.token, col, row)
        {board, col, row}
    end
  end
end
