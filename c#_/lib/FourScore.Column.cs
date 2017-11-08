/*
 * "Top" of column is index 0
 */

public partial class FourScore
{
  private class Column
  {
    public bool IsOpen => this.pieces < this.rows.Length;
    public char? this[int row] => this.rows[row] ?? ' ';

    private int pieces = 0;
    private char?[] rows;

    public Column(int rowCount)
    {
      this.rows = new char?[rowCount];
    }

    public int AddPiece(char token)
    {
      if (!IsOpen)
        return -1;

      int openRow = this.rows.Length - this.pieces - 1;
      this.rows[openRow] = token;
      ++this.pieces;

      return openRow;
    }
  }
}
