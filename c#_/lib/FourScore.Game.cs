using System;
using System.Collections.Generic;

public partial class FourScore
{
  private class Game
  {
    private List<Player> _players = new List<Player>();
    private int _currentPlayer = 0;
    private Board _board;

    public void Play()
    {
      CreatePlayers();
      CreateBoard();
      _board.Draw();

      while (!_board.IsFinished)
        PlayRound();

      Console.WriteLine("Game is over!");
    }

    private void PlayRound()
    {
      Player p = _players[_currentPlayer];
      int column, row;

      Console.Write($"[{p.Token}] {p.Name}, please select a column: ");

      while (true)
      {
        // Columns are 1-based on UI
        column = GetIntInRange(1, _board.ColumnCount) - 1;
        row = _board.AddPiece(column, p.Token);

        if (row > -1)
          break;

        Console.Write($"Column {column} is full, please select an open column: ");
      }
      _board.Draw();
      _board.CheckForWin(column, row);
      _currentPlayer = 1 - _currentPlayer;
    }

    private void CreatePlayers()
    {
      Console.Write("\nFirst player: ");
      AddPlayer('X');
      Console.Write("\nSecond player: ");
      AddPlayer('O');
    }

    private void AddPlayer(char token)
    {
      _players.Add(new Player(GetPlayerName(), token));
    }

    private string GetPlayerName()
    {
      string name;

      while (true)
      {
        name = Console.ReadLine();

        if (name == "")
          Console.Write("Please enter a name: ");
        else if (_players.Exists(p => p.Name == name))
          Console.Write("Please enter a unique name: ");
        else
          return name;
      }
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
      _board = new Board(7, 7);
    }

    private void CreateCustomBoard()
    {
      Console.Write("Number of columns (4-9): ");
      int columns = GetIntInRange(4, 9);
      Console.Write("Number of rows (4-9): ");
      int rows = GetIntInRange(4, 9);

      _board = new Board(columns, rows);
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
