using System;
using System.Text;

public partial class FourScore
{
  private class Board
  {
    public bool IsFinished { get; private set; } = false;
    public int ColumnCount { get; private set; }

    private Column[] _columns;
    private int _rowLength;

    public Board(int columns, int rows)
    {
      ColumnCount = columns;
      _rowLength = rows;
      _columns = new Column[columns];

      for (int i = 0; i < columns; ++i)
        _columns[i] = new Column(rows);
    }

    public void Draw()
    {
      StringBuilder output = new StringBuilder('\n');

      for (int row = 0; row < _rowLength; ++row)
      {
        output.Append('|');

        for (int col = 0; col < ColumnCount; ++col)
          output.Append($"{_columns[col][row]} ");

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

    public int AddPiece(int col, char token)
    {
      Column column = _columns[col];

      if (!column.IsOpen)
        return -1;

      return column.AddPiece(token);
    }

    public void CheckForWin(int col, int row)
    {
      if (
        CheckVertical(col, row)       ||
        CheckDirections(col, row)     || // horizontal
        CheckDirections(col, row, -1) || // diagonal \
        CheckDirections(col, row,  1)    // diagonal /
      )
        IsFinished = true;

      // Check if draw TODO
      // Check for draw only if row is 0
    }

    private bool CheckVertical(int col, int row)
    {
      if (row > _rowLength - 4)
        return false;

      return CountByIncrement(col, row, 0, 1) > 2;
    }

    private bool CheckDirections(int col, int row, int rowInc = 0)
    {
      return (
        CountByIncrement(col, row,  1, 0 + rowInc) +
        CountByIncrement(col, row, -1, 0 - rowInc)
      ) > 2;
    }

    private int CountByIncrement(int col, int row, int colInc, int rowInc, int count = 0)
    {
      int newCol = col + colInc;
      int newRow = row + rowInc;

      try
      {
        char? token = _columns[col][row];
        char? nextToken = _columns[newCol][newRow];

        if (nextToken == token)
          return CountByIncrement(newCol, newRow, colInc, rowInc, count + 1);
      }
      catch (IndexOutOfRangeException) {}

      return count;
    }
  }
}
