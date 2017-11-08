using System;
using System.Collections.Generic;
using System.Linq;

public partial class FourScore
{
  private List<Player> players = new List<Player>();
  private Dictionary<string, int> wins = new Dictionary<string, int>();
  private int gamesPlayed = 0;

  public void Run()
  {
    Console.WriteLine("Welcome to FourScore C#!");
    CreatePlayers();
    string play = "y";

    while (play == "y")
    {
      Game game = new Game();
      Player winner = game.Play(this.players);
      play = PlayAgain();
      this.gamesPlayed++;

      if (winner != null)
        this.wins[winner.Name]++;
    }
    PrintStats();
    Console.WriteLine("\nThanks for playing!");
  }

  private string PlayAgain()
  {
    string[] choices = { "y", "n" };
    string choice;

    Console.Write("Play again (y/n): ");

    while (true)
    {
      choice = Console.ReadLine().ToLower();

      if (Array.IndexOf(choices, choice) >= 0)
        break;

      Console.Write("Please enter a valid choice (y/n): ");
    }

    return choice;
  }

  private void PrintStats()
  {
    // TODO: do not pluralize for 1 draws/wins
    int draws = this.gamesPlayed - this.wins.Sum(x => x.Value);
    Console.WriteLine($"\nTOTAL GAMES: {this.gamesPlayed}");
    Console.WriteLine($"  {draws} draws");
    this.players.ForEach(delegate(Player p)
    {
      int wins = this.wins[p.Name];
      Console.WriteLine($"  {wins} wins for {p.Name}");
    });
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
    Player p = new Player(GetPlayerName(), token);
    this.players.Add(p);
    this.wins[p.Name] = 0;
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
