using System;

public partial class FourScore
{
  private class Game
  {
    private Player[] Players = new Player[2];

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

      int[] options = {1, 2};
      int choice;

      while (true) {
        int.TryParse(Console.ReadLine(), out choice);

        if (Array.IndexOf(options, choice) > -1)
          break;

        Console.Write("Please enter a valid choice: ");
      }

      if (choice == 1)
        CreateBasicBoard();
      else
        CreateCustomBoard();
    }

    private void CreateBasicBoard()
    {
      Console.WriteLine("You chose standard board");
    }

    private void CreateCustomBoard()
    {
      Console.WriteLine("You chose custom board");
    }
  }
}
