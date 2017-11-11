using Xunit;

public partial class FourScore
{
  public class Board_Test
  {
    [Theory]
    [InlineData(1)]
    [InlineData(2)]
    [InlineData(5)]
    public void ColumnCount_ReturnsLength(int columnCount)
    {
      Board b = new Board(columnCount, 5);
      Assert.Equal(columnCount, b.ColumnCount);
    }
  }
}
