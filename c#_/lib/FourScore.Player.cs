namespace FourScore
{
  internal class Player
  {
    public string Name { get; }
    public char Token { get; }
    public int Wins { get; set; } = 0;

    public Player(string name, char token)
    {
      Name = name;
      Token = token;
    }
  }
}
