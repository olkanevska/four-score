defmodule Fourscore do
  defstruct players: [], board: "board"

  @tokens [first: "O", second: "X"]

  def new, do: %Fourscore{}

  def create_players(fourscore) do
    %Fourscore{fourscore |
      players: Enum.map(@tokens, fn {ordinal, token} ->
        Player.new(
          name: prompt("Enter #{ordinal} player: "),
          token: token
        )
      end)
    }
  end

  def create_board(fourscore) do
    # TODO: Update .prompt so it checks input values
    %Fourscore{fourscore |
      board: case prompt("\nUse (1) standard or (2) custom board: ") do
        "1" ->
          Board.new
        _ ->
          Board.new(
            rows: prompt("Number of rows (4-16): "),
            columns: prompt("Number of columns (4-16): ")
          )
      end
    }
  end

  defp prompt(string), do: string |> IO.gets |> String.trim
end
