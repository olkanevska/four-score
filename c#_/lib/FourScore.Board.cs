using System;

public partial class FourScore
{
  private class Board
  {
    private int Columns;
    private int Rows;
    private char[,] Matrix;

    public Board(int columns, int rows)
    {
      Columns = columns;
      Rows = rows;
      Matrix = new char[columns, rows];
    }
  }
}
