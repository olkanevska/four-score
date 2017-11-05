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
      // Check if draw TODO

      if (
        CheckVertical(col, row)   //||
        // CheckHorizontal(col, row) ||
        // CheckDiagonal(col, row)   ||
        // CheckAntidiagonal(col, row)
      )
        IsFinished = true;

      // Check for draw only if row is 0
    }

    private bool CheckVertical(int col, int row)
    {
      if (row < 3)
        return false;

      int count = 1;
      char? token = _columns[col][row];

      for (int r = row + 1; r < _rowCount; r++)
      {
        if (_columns[col][r] != token)
          break;
        count++;
      }
      return count > 3;
    }

    private bool CheckHorizontal(int col, int row)
    {
    }

    private bool CheckByIncrement(int col, int row, int colIncrement, int rowIncrement)
    {
      // char token = _columns[col][row];
      return false;
    }
  }
}
