using System;
using System.Collections.Generic;

public partial class FourScore
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
