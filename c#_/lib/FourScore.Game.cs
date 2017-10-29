using System;

public partial class FourScore
{
  private class Game
  {
    private Player[] Players = new Player[2];
    private Board GameBoard;

    public void Play()
    {
      GetPlayers();
      ChooseBoard();
    }

    private void GetPlayers()
    {
      Console.Write("\nFirst player: ");
      Players[0] = new Player(Console.ReadLine(), 'X');

      Console.Write("\nSecond player: ");
      Players[1] = new Player(Console.ReadLine(), 'O');

      while (
        Players[0].Name == Players[1].Name ||
        Players[1].Name == String.Empty
      )
      {
        Console.Write(
          "Please enter a{0} name: ",
          Players[0].Name == Players[1].Name ? " unique" : ""
        );
        Players[1].Name = Console.ReadLine();
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
