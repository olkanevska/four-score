/*
 * "Top" of column is index 0, "bottom" is index <cellCount>
 */

public partial class FourScore
{
  private class Column
  {
    public bool IsOpen { get; private set; } = true;

    private int _pieces = 0;
    private char?[] _cells;

    public Column(int cellCount)
    {
      _cells = new char?[cellCount];
    }

    public int AddPiece(char token)
    {
      int openCell = _cells.Length - _pieces - 1;
      _cells[openCell] = token;
      ++_pieces;

      if (_pieces == _cells.Length)
        IsOpen = false;

      return openCell;
    }

    public char? ContentAt(int cell)
    {
      if (_cells[cell] == null)
        return ' ';

      return _cells[cell];
    }
  }
}
