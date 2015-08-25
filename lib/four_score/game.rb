module FourScore
  class Game
    attr_reader :players, :board, :current_player, :next_player

    def initialize(players, board = Board.new)
      @players = players
      @board = board
      @current_player, @next_player = players
    end

    def switch_players
      @current_player, @next_player = @next_player, @current_player
    end

    def move_prompt
      "[#{@current_player.token}] #{@current_player.name}, please select a column: "
    end

    def valid_prompt
      "Please select a valid column: "
    end

    def open_prompt(column)
      "Column #{column} is full, please select an open column: "
    end

    def get_move(move = gets.chomp.to_i)
      until board.valid_move?(move) && board.column_open?(move)
        if board.column_open?(move)
          print valid_prompt
        else
          print open_prompt(move)
        end
        move = gets.chomp.to_i
      end
      move
    end

    def play
      while true
        puts board.display
        puts

        print move_prompt
        column = get_move

        puts

        board.drop_into_column(column, current_player.token)

        if board.victory?(column, current_player.token)
          puts board.display
          puts
          puts "#{current_player.name} wins!"
          break
        elsif board.draw?
          puts board.display
          puts
          puts "The game is a draw"
          break
        else
          switch_players
        end

      end
    end
  end
end


# def play
#   puts "#{current_player.name} has randomly been selected as the first player"
#   while true
#     board.formatted_grid
#     puts ""
#     puts solicit_move
#     x, y = get_move
#     board.set_cell(x, y, current_player.color)
#     if board.game_over
#       puts game_over_message
#       board.formatted_grid
#       return
#     else
#       switch_players
#     end
#   end
# end