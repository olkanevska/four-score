using Xunit;

namespace FourScore
{
  public class Player_Test
  {
    [Fact]
    public void NewPlayer()
    {
      Player p = new Player("Korben", 'x');

      Assert.Equal("Korben", p.Name);
      Assert.Equal('x', p.Token);
      Assert.Equal(0, p.Wins);
    }
  }
}
