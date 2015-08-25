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
    # Each player move prompts #victory? on the played column.
    # There are at most 13 winning combinations that a move can
    # be a part of:
    #  - 4 each of horizontal and both diagonals
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
      @rows = options.fetch(:rows, 6)
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

      check_verticals(x_translate(column), y, piece) ||
      check_horizontals(x_translate(column), y, piece) ||
      check_diagonals(x_translate(column), y, piece)
    end

    def draw?
      !grid.flatten.include?(nil)
    end

    private

      def has_four_score?(array, value)
        array.count == 4 &&
        array.uniq.count == 1 &&
        array.uniq.include?(value)
      end

      def check_verticals(x, y, value)
        return false if y > rows - 4
        cell_contents = [
          coords(x, y),
          coords(x, y+1),
          coords(x, y+2),
          coords(x, y+3)
        ]
        return has_four_score?(cell_contents, value)
      end

      def check_horizontals(x, y, value)
        x_lower = (x - 3 < 0) ? 0 : x - 3
        x_upper = (x + 3 > columns - 1) ? columns - 4 : x

        (x_lower..x_upper).each do |i|
          cell_contents = [
            coords(i, y),
            coords(i+1, y),
            coords(i+2, y),
            coords(i+3, y)
          ]
          return true if has_four_score?(cell_contents, value)
        end

        return false
      end

      def check_diagonals(x, y, value)
        # \ diagonals

        # / diagonals
        return false
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
