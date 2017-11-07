using System;
using System.Collections.Generic;

public partial class FourScore
{
  private class Game
  {
    private int currentPlayer;
    private Board board;

    public Game(int currentPlayer = 0)
    {
      this.currentPlayer = currentPlayer;
    }

    public void Play(List<Player> players)
    {
      CreateBoard();
      this.board.Draw();

      while (this.board.IsPlayable)
      {
        PlayRound(players[this.currentPlayer]);
        this.currentPlayer = 1 - this.currentPlayer;
      }

      if (this.board.IsWin)
      {
        Player p = players[1 - this.currentPlayer];
        Console.WriteLine($"{p.Name} wins!");
      }
      else
      {
        Console.WriteLine("Game is a draw.");
      }
    }

    private void PlayRound(Player p)
    {
      int column, row;
      Console.Write($"[{p.Token}] {p.Name}, please select a column: ");

      while (true)
      {
        column = GetIntInRange(1, this.board.ColumnCount) - 1;
        row = this.board.AddPiece(column, p.Token);

        if (row > -1)
          break;

        Console.Write($"Column {column + 1} is full, please select an open column: ");
      }
      this.board.Draw();
      this.board.CheckIfDone(column, row);
    }

    private void CreateBoard()
    {
      Console.Write("\nPlay with a (1) standard or (2) custom board: ");
      int choice = GetIntInRange(1, 2);

      if (choice == 1)
        CreateBasicBoard();
      else
        CreateCustomBoard();
    }

    private void CreateBasicBoard()
    {
      this.board = new Board(7, 7);
    }

    private void CreateCustomBoard()
    {
      Console.Write("Number of columns (4-9): ");
      int columns = GetIntInRange(4, 9);
      Console.Write("Number of rows (4-9): ");
      int rows = GetIntInRange(4, 9);

      this.board = new Board(columns, rows);
    }

    private int GetIntInRange(int lower, int upper)
    {
      int choice;

      while (true)
      {
        bool parsed = int.TryParse(Console.ReadLine(), out choice);

        if (parsed && choice >= lower && choice <= upper)
          return choice;

        Console.Write("Please enter a valid choice: ");
      }
    }
  }
}
