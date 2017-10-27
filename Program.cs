using System;

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

  class App
  {
    public Player[] Players = new Player[2];

    public void Run()
    {
      Console.WriteLine("Welcome to Four Score!");

      GetPlayers();
      ChooseBoard();
    }

    private void GetPlayers()
    {
      Console.Write("First player: ");
      Players[0] = new Player(Console.ReadLine(), 'X');

      Console.Write("Second player: ");
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
    }
  }

  class Program
  {
    static void Main(string[] args)
    {
      App app = new App();
      app.Run();
    }
  }
}
