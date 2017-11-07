using System;
using System.Text;

public partial class FourScore
{
  private class Board
  {
    public int ColumnCount => this.columns.Length;
    public bool IsPlayable => !IsWin && !IsDraw;
    public bool IsWin  { get; private set; }
    public bool IsDraw { get; private set; }

    private Column[] columns;
    private int rowLength;

    public Board(int columns, int rows)
    {
      this.rowLength = rows;
      this.columns = new Column[columns];

      for (int i = 0; i < columns; ++i)
        this.columns[i] = new Column(rows);
    }

    public void Draw()
    {
      StringBuilder output = new StringBuilder();

      for (int row = 0; row < this.rowLength; ++row)
      {
        output.Append('|');

        for (int col = 0; col < ColumnCount; ++col)
          output.Append($"{this.columns[col][row]} ");

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
      Console.WriteLine();
      Console.WriteLine(output.ToString());
    }

    public int AddPiece(int col, char token)
    {
      Column column = this.columns[col];
      return column.IsOpen ? column.AddPiece(token) : -1;
    }

    public void CheckIfDone(int col, int row)
    {
      if (CheckIfWon(col, row))
        IsWin = true;
      else if (CheckIfDraw(row))
        IsDraw = true;
    }

    private bool CheckIfWon(int col, int row)
    {
      return
        CheckVertical(col, row)       ||
        CheckDirections(col, row)     || // horizontal
        CheckDirections(col, row, -1) || // diagonal \
        CheckDirections(col, row,  1);   // diagonal /
    }

    private bool CheckIfDraw(int row)
    {
      if (row > 0)
        return false;

      for (int col = 0; col < ColumnCount; col++)
        if (this.columns[col].IsOpen)
            return false;

      return true;
    }

    private bool CheckVertical(int col, int row)
    {
      if (row > this.rowLength - 4)
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
        char? token = this.columns[col][row];
        char? nextToken = this.columns[newCol][newRow];

        if (nextToken == token)
          return CountByIncrement(newCol, newRow, colInc, rowInc, count + 1);
      }
      catch (IndexOutOfRangeException) {}

      return count;
    }
  }
}
