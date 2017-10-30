using System;
using System.Collections.Generic;

public partial class FourScore
{
  private class Game
  {
    private List<Player> Players = new List<Player>();
    private Board GameBoard;

    public void Play()
    {
      GetPlayers();
      ChooseBoard();
    }

    private void GetPlayers()
    {
      Console.Write("\nFirst player: ");
      AddPlayer('X');

      Console.Write("\nSecond player: ");
      AddPlayer('O');
    }

    private void AddPlayer(string token)
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

    private void ChooseBoard()
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
      Console.Write("Number of columns (4-16): ");
      int columns = GetIntInRange(4, 16);

      Console.Write("Number of rows (4-16): ");
      int rows = GetIntInRange(4, 16);

      GameBoard = new Board(columns, rows);
    }

    private int GetIntInRange(int lower, int upper)
    {
      int choice;

      while (true) {
        int.TryParse(Console.ReadLine(), out choice);

        if (choice >= lower && choice <= upper)
          return choice;

        Console.Write("Please enter a valid choice: ");
      }
    }
  }
}
