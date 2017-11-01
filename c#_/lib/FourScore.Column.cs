/*
 * "Top" of column is index 0, "bottom" is index <cellCount>
 */

public partial class FourScore
{
  private class Column
  {
    public bool IsOpen { get; private set; } = true;

    private int Pieces = 0;
    private char?[] Cells;

    public Column(int cellCount)
    {
      Cells = new char?[cellCount];
    }

    public void AddPiece(char token)
    {
      int openCell = Cells.Length - Pieces - 1;

      Cells[openCell] = token;
      ++Pieces;

      if (Pieces == Cells.Length)
        IsOpen = false;
    }

    public char? ContentAt(int cell)
    {
      if (Cells[cell] == null)
        return ' ';

      return Cells[cell];
    }
  }
}
