using System;

public partial class FourScore
{
  private class Board
  {
    public int Rows;
    public int Columns;
    public bool IsNotFinished = true;

    private char[,] Matrix;

    public Board(int rows, int columns)
    {
      Rows = rows;
      Columns = columns;
      Matrix = new char[rows, columns];

      for (int row = 0; row < Rows; row++)
      {
        for (int col = 0; col < Columns; ++col)
          Matrix[row, col] = ' ';
      }
    }

    public void Draw()
    {
      string output = "\n";

      for (int row = 0; row < Rows; ++row)
      {
        output += "|";
        for (int col = 0; col < Columns; ++col)
        {
          output += Matrix[row, col];
          if (col < Columns - 1)
            output += " ";
        }
        output += "|\n";
      }

      output += "+" + new String('-', 2 * (Columns - 1)) + "-+\n ";

      for (int col = 1; col <= Columns; ++col)
        output += $"{col} ";

      Console.WriteLine(output);
    }

    public void CheckState()
    {
      IsNotFinished = false;
      // Check if draw
      // Check if winning move
    }

    public bool IsValidMove(int column)
    {
      // Just check top row
      return true;
    }

    public void AddPiece(int column, char token)
    {
    }
  }
}
