using System;
using System.Collections.Generic;

public partial class FourScore
{
  private List<Player> players = new List<Player>();

  public void Run()
  {
    Console.WriteLine("Welcome to Four Score!");
    CreatePlayers();
    (new Game()).Play(this.players);
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
    this.players.Add(new Player(GetPlayerName(), token));
  }

  private string GetPlayerName()
  {
    string name;

    while (true)
    {
      name = Console.ReadLine();

      if (name == "")
        Console.Write("Please enter a name: ");
      else if (this.players.Exists(p => p.Name == name))
        Console.Write("Please enter a unique name: ");
      else
        return name;
    }
  }
}
