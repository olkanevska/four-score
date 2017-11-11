using Xunit;

public partial class FourScore
{
  public class Column_Test
  {
    private int rowCount = 4;

    private Column NewColumn()
    {
      return new Column(this.rowCount);
    }

    [Theory]
    [InlineData(1)]
    [InlineData(2)]
    [InlineData(3)]
    public void IsOpen_TrueForOpenColumn(int pieces)
    {
      Column col = NewColumn();
      for (int i = 0; i < pieces; ++i)
        col.AddPiece('x');
      Assert.Equal(true, col.IsOpen);
    }

    [Fact]
    public void IsOpen_FalseForFullColumn()
    {
      Column col = NewColumn();
      for (int i = 0; i < this.rowCount; ++i)
        col.AddPiece('x');
      Assert.Equal(false, col.IsOpen);
    }


    [Theory]
    [InlineData(0)]
    [InlineData(1)]
    [InlineData(2)]
    [InlineData(3)]
    public void Indexer_ReturnsTokenOrDefault(int row)
    {
      Column col = NewColumn();
      Assert.Equal(' ', col[row]);
      for (int i = 0; i < row + 1; ++i)
        col.AddPiece('x');
      Assert.Equal('x', col[this.rowCount - row - 1]);
    }

    [Fact]
    public void AddPiece_ReturnsRowPositionOfNewPiece()
    {
      Column col = NewColumn();
      Assert.Equal( 3, col.AddPiece('x'));
      Assert.Equal( 2, col.AddPiece('x'));
      Assert.Equal( 1, col.AddPiece('x'));
      Assert.Equal( 0, col.AddPiece('x'));
      Assert.Equal(-1, col.AddPiece('x'));
      Assert.Equal(-1, col.AddPiece('x'));
    }
  }
}
