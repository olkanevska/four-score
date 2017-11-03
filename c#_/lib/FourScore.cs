using System;
using System.Collections.Generic;

public partial class FourScore
{
  private List<Game> _games = new List<Game>();

  public void Run()
  {
    Console.WriteLine("Welcome to Four Score!");

    Game game = new Game();
    _games.Add(game);
    game.Play();
  }
}
