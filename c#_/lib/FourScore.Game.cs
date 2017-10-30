using System;
using System.Collections.Generic;

public partial class FourScore
{
  private class Game
  {
    private Board GameBoard;
    private List<Player> Players = new List<Player>();
    private int CurrentPlayer = 0;

    public void Play()
    {
      CreatePlayers();
      CreateBoard();

      while (GameBoard.IsNotFinished)
        PlayRound();

      Console.WriteLine("Game is over!");
    }

    private void PlayRound()
    {
      GameBoard.Draw();

      Player p = Players[CurrentPlayer];
      Console.Write($"[{p.Token}] {p.Name}, please select a column: ");

      int move;

      while (true)
      {
        move = GetIntInRange(1, GameBoard.Columns);

        if (GameBoard.IsValidMove(move))
          break;

        Console.Write("Column {move} is full, please select an open column: ");
      }

      GameBoard.AddPiece(move, p.Token);
      GameBoard.CheckState();

      CurrentPlayer = 1 - CurrentPlayer;
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
      Players.Add(new Player(GetPlayerName(), token));
    }

    private string GetPlayerName()
    {
      string name;

      while (true)
      {
        name = Console.ReadLine();

        if (name == "")
          Console.Write("Please enter a name: ");
        else if (Players.Exists(p => p.Name == name))
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
      GameBoard = new Board(7, 7);
    }

    private void CreateCustomBoard()
    {
      Console.Write("Number of rows (4-16): ");
      int rows = GetIntInRange(4, 16);

      Console.Write("Number of columns (4-16): ");
      int columns = GetIntInRange(4, 16);

      GameBoard = new Board(rows, columns);
    }

    private int GetIntInRange(int lower, int upper)
    {
      int choice;

      while (true) {
        bool parsed = int.TryParse(Console.ReadLine(), out choice);

        if (parsed && choice >= lower && choice <= upper)
          return choice;

        Console.Write("Please enter a valid choice: ");
      }
    }
  }
}
