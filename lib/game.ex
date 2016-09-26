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
    case player_move(game) do
      {:win, player} -> %Game{game | victor: player}
      {:draw}        -> game
      {:ok, board}   ->
        loop(%Game{game | board: board, next_player: 1 - game.next_player})
    end
  end

  def finish(%Game{victor: victor}) when victor do nil end
  def finish(_game), do: nil

  defp player_move(game) do
    player = Enum.at(game.players, game.next_player)

    "#{player.name}, choose column: "
    |> choose_column(game)
    |> check_winner()

    {:ok, game.board}
  end

  defp choose_column(prompt, game) do
    get_num(prompt, 1, game.board.columns)
  end

  defp check_winner(game) do
    game
  end
end
