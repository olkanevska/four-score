using System;
using System.Collections.Generic;
using System.Linq;

public partial class FourScore
{
  private List<Player> players = new List<Player>();
  private int gamesPlayed = 0;

  public void Run()
  {
    int startingPlayer = 0;
    Console.WriteLine("Welcome to FourScore C#!");
    CreatePlayers();

    do
    {
      Game game = new Game(startingPlayer);
      Player winner = game.Play(this.players);

      if (winner != null)
        ++winner.Wins;

      ++this.gamesPlayed;
      startingPlayer = 1 - startingPlayer;
    }
    while (PlayAgain());

    PrintStats();
    Console.WriteLine("\nThanks for playing!");
  }

  private bool PlayAgain()
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

    return choice == "y";
  }

  private void PrintStats()
  {
    // TODO: do not pluralize for 1 draws/wins
    int draws = this.gamesPlayed - this.players.Sum(p => p.Wins);

    Console.WriteLine($"\nTOTAL GAMES: {this.gamesPlayed}");
    Console.WriteLine($"  {draws} draws");

    this.players.ForEach(p => Console.WriteLine($"  {p.Wins} wins for {p.Name}"));
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
