using System;
using System.Collections.Generic;
using System.Linq;

namespace fourscore_csharp
{
  class Player
  {
    public string Name;
    public char Token;

    public Player(string name, char token)
    {
      Name = name;
      Token = token;
    }
  }

  class Game
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

      // TODO: Try to not repeat input logic
      int.TryParse(Console.ReadLine(), out choice);
      while (!options.Contains(choice))
      {
        Console.Write("Please enter a valid choice: ");
        int.TryParse(Console.ReadLine(), out choice);
      }

      Console.WriteLine($"You chose {choice}");
    }
  }

  class FourScore
  {
    private List<Game> Games = new List<Game>();

    public void Run()
    {
      Console.WriteLine("Welcome to Four Score!");

      Game game = new Game();
      Games.Add(game);
      game.Play();
    }

  }

  class Program
  {
    static void Main(string[] args)
    {
      FourScore fourscore = new FourScore();
      fourscore.Run();
    }
  }
}
