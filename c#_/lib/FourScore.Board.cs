using System;
using System.Text;

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
      StringBuilder output = new StringBuilder('\n');

      for (int row = 0; row < _rowCount; ++row)
      {
        output.Append('|');

        for (int col = 0; col < ColumnCount; ++col)
          output.Append($"{_columns[col].ContentAt(row)} ");

        output[output.Length - 1] = '|';
        output.Append('\n');
      }
      output.Append('+');

      for (int col = 1; col < ColumnCount * 2; col++)
        output.Append('-');

      output.Append("+\n");

      for (int col = 0; col < ColumnCount; col++)
        output.Append($" {col + 1}");

      output.Append('\n');
      Console.WriteLine(output.ToString());
    }

    public bool AddPiece(int column, char token)
    {
      // From UI perspective, columns are 1-based
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
