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
        CheckVertical(col, row)   ||
        CheckHorizontal(col, row) //||
        // CheckDiagonal(col, row)   ||
        // CheckAntidiagonal(col, row)
      )
        IsFinished = true;

      // Check if draw TODO
      // Check for draw only if row is 0
    }

    private bool CheckVertical(int col, int row)
    {
      if (row < 3)
        return false;

      return CountByIncrement(col, row, 0, 1) > 2;
    }

    private bool CheckHorizontal(int col, int row)
    {
      return (
        CountByIncrement(col, row, -1, 0) +
        CountByIncrement(col, row,  1, 0)
      ) > 2;
    }

    private int CountByIncrement(int col, int row, int colInc, int rowInc, int count = 0)
    {
      int newCol = col + colInc;
      int newRow = row + rowInc;

      if (!ValidCoords(newCol, newRow))
          return count;

      char? token = _columns[col][row];
      char? nextToken = _columns[newCol][newRow];

      if (nextToken == token)
        return CountByIncrement(newCol, newRow, colInc, rowInc, count + 1);

      return count;
    }

    private bool ValidCoords(int col, int row)
    {
      // TODO: clean this up
      return
        col >= 0 && row >= 0 &&
        col < _columns.Length && row < _rowLength;

    }
  }
}
