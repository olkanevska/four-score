using System;

public partial class FourScore
{
  private class Board
  {
    public bool IsFinished { get; private set; } = false;
    public int ColumnCount { get; private set; }

    private Column[] _columns;
    private int _rowCount;

    public Board(int columns, int rows)
    {
      ColumnCount = columns;
      _rowCount = rows;
      _columns = new Column[columns];

      for (int i = 0; i < columns; ++i)
        _columns[i] = new Column(rows);
    }

    public void Draw()
    {
      string output = "\n";

      for (int y = 0; y < _rowCount; ++y)
      {
        output += "|";

        for (int x = 0; x < ColumnCount; ++x)
        {
          output += _columns[x].ContentAt(y);
          if (x < ColumnCount - 1)
            output += ' ';
        }
        output += "|\n";
      }
      output += "+" + new String('-', 2 * (ColumnCount - 1)) + "-+\n ";

      for (int col = 1; col <= ColumnCount; ++col)
        output += $"{col} ";

      output += '\n';
      Console.WriteLine(output);
    }

    public bool AddPiece(int column, char token)
    {
      // From UI perspective, "columns" are 1-based
      Column col = _columns[column - 1];

      if (!col.IsOpen)
        return false;

      int row = col.AddPiece(token);

      CheckState(column, row);

      return true;
    }

    private void CheckState(int col, int row)
    {
      // Check if draw
      // Check if winning move
      // IsFinished = true;
    }
  }
}
