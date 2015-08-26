module FourScore
  class Board
    # COORDINATE SYSTEM:
    #
    # PUBLIC INTERFACE      PRIVATE INTERFACE
    # Cartesian             Underlying data structure
    #
    # 4|         |           0|         |
    # 3|         |           1|         |
    # 2|         |    ->     2|         |
    # 1|_________|           3|_________|
    #   1 2 3 4 5              0 1 2 3 4
    #
    # Private methods expect zero-based indices with a top-left origin,
    # so public methods (based on more readable Cartesian coordinates)
    # pass translated versions of the coords into private methods

    # VICTORY CONDITION:
    #
    # There are at most 13 winning combinations that a move can
    # be a part of:
    #  - 4 each of horizontal and both diagonal directions
    #  - 1 vertical (as the last played piece will be on top)
    #
    # (Smaller board sizes will often require fewer checks.)
    #
    # These are each checked by individual #check_horizontal, etc methods
    # which calculate and test groups of cells for having unique values.
    # Each method checks only the minimum number set of cells necessary, given
    # that a play made by the edge of the board has fewer than 4 sets to check.

    attr_reader :grid, :rows, :columns

    def initialize(options = {})
      @rows = options.fetch(:rows, 7)
      @columns = options.fetch(:columns, 7)
      @grid = Array.new(@rows) { Array.new(@columns) }
    end

    def display
      board = ""
      grid.each do |row|
        board << "|"
        board << row.map { |cell| cell || " " } .join(" ")
        board << "|\n"
      end
      board << "+" << "--" * (columns - 1) << "-+\n"
      board << " "
      board << (1..columns).to_a.join(" ")
    end

    def position(x, y)
      coords(x_translate(x), y_translate(y))
    end

    def valid_move?(column)
      (1..columns).include?(column)
    end

    def column_open?(column)
      coords(x_translate(column), 0).nil?
    end

    def drop_into_column(column, piece)
      place_piece(x_translate(column), piece)
    end

    def victory?(column, piece)
      y = find_top_piece(x_translate(column))

      check_vertical(x_translate(column), y, piece) ||
      check_horizontal(x_translate(column), y, piece) ||
      check_diagonals(x_translate(column), y, piece)
    end

    def draw?
      !grid.flatten.include?(nil)
    end

    private

      def check_vertical(x, y, value)
        return false if y > rows - 4
  
        count = 1

        # Count down
        i = y + 1
        while i < rows && coords(x, i) == value
          count += 1
          i += 1
        end

        count >= 4
      end

      def check_horizontal(x, y, value)
        count = 1

        # Check left
        i = x - 1
        while i >= 0 && coords(i, y) == value
          count += 1
          i -= 1
        end

        # Check right
        i = x + 1
        while i < columns && coords(i, y) == value
          count += 1
          i += 1
        end

        count >= 4
      end

      def check_diagonals(x, y, value)
        check_diagonal_1(x, y, value) || check_diagonal_2(x, y, value)
      end

      def check_diagonal_1(x, y, value)
        # DIAGONAL DIRECTION '\'
        count = 1

        # Check up-left
        i = x - 1
        j = y - 1
        while i >= 0 && j >= 0 && coords(i, j) == value
          count += 1
          i -= 1
          j -= 1
        end

        # Check down-right
        i = x + 1
        j = y + 1
        while i < columns && j < rows && coords(i, j) == value
          count += 1
          i += 1
          j += 1
        end

        count >= 4
      end

      def check_diagonal_2(x, y, value)
        # DIAGONAL DIRECTION '/'
        count = 1

        # Check up-right
        i = x + 1
        j = y - 1
        while i < columns && j >= 0 && coords(i, j) == value
          count += 1
          i += 1
          j -= 1
        end

        # Check down-left
        i = x - 1
        j = y + 1
        while i >= 0 && j < rows && coords(i, j) == value
          count += 1
          i -= 1
          j += 1
        end

        count >= 4
      end

      def find_top_piece(x)
        (0...rows).each do |y|
          return y unless coords(x, y).nil?
        end
        return -1
      end

      def place_piece(x, value, y = rows - 1)
        return false if y < 0
        if coords(x, y).nil?
          set_coords(x, y, value)
          return true
        else
          place_piece(x, value, y - 1)
        end
      end

      def coords(x, y)
        grid[y][x]
      end

      def set_coords(x, y, value)
        grid[y][x] = value
      end

      def x_translate(x)
        x - 1
      end

      def y_translate(y)
        rows - y
      end
  end
end
