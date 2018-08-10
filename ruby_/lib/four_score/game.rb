module FourScore
  class Game
    attr_reader :current_player, :next_player, :board, :winner

    def initialize(players, board = Board.new)
      @board = board
      @current_player, @next_player = players
      @finished = false
      @winner = nil
    end

    def play
      until @finished
        print_board
        print move_prompt
        current_move

        @board.drop_into_column(@current_move, @current_player.token)

        if @board.victory?(@current_move, @current_player.token)
          victory_action
        elsif @board.draw?
          draw_action
        else
          switch_players
        end
      end
    end

    private

    def draw_action
      print_board
      puts 'The game is a draw'
      @finished = true
    end

    def victory_action
      print_board
      puts "#{@current_player.name} wins!"
      @winner = @current_player
      @finished = true
    end

    def switch_players
      @current_player, @next_player = @next_player, @current_player
    end

    def print_board
      puts @board.display
    end

    def move_prompt
      "[#{@current_player.token}] #{@current_player.name}, please select a column: "
    end

    def valid_prompt
      "\nPlease select a valid column: "
    end

    def open_prompt(column)
      "\nColumn #{column} is full, please select an open column: "
    end

    def current_move(move = gets.chomp.to_i)
      until @board.valid_move?(move) && @board.column_open?(move)
        print @board.column_open?(move) ? valid_prompt : open_prompt(move)
        move = gets.chomp.to_i
      end
      @current_move = move
    end
  end
end
