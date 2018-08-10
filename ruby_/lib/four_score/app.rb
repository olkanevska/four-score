module FourScore
  class App
    def initialize
      @invalid_names = [""]
      @players = []
      @games = []
      @game_scores = Hash.new(0)
    end

    def run
      put_welcome
      init_players

      loop do
        make_board
        play_game
        process_game
        prompt_play_again
        break unless respond_with_yes?
      end

      put_statistics
      put_goodbye
    end

    private

    def put_welcome
      puts "Welcome to FourScore!\n"
    end

    def put_goodbye
      puts "\nThanks for playing FourScore!"
    end

    def put_statistics
      puts "\nTOTAL GAMES: #{@games.count}"
      draws = @game_scores[:draws]
      puts "  #{draws} draw#{'s' unless draws == 1}"
      player1 = @players.first.name
      player2 = @players.last.name
      wins1 = @game_scores[player1]
      wins2 = @game_scores[player2]
      puts_stat(wins1, wins2, player1, player2)
    end

    def puts_stat(wins1, wins2, player1, player2)
      puts "  #{wins1} win#{'s' unless wins1 == 1} for #{player1}"
      puts "  #{wins2} win#{'s' unless wins2 == 1} for #{player2}"
    end

    def init_players
      print "\nEnter first player: "
      @players << FourScore::Player.new(name: init_name, token: "X")
      print "\nEnter second player: "
      @players << FourScore::Player.new(name: init_name, token: "O")
    end

    def make_board
      print "\nPlay with a (1) standard or (2) custom board: "
      board_choice = choose(1, 2)

      options = {}
      if board_choice == 2
        print "\nNumber of columns (4-16): "
        options[:columns] = choose(4, 16)
        print "\nNumber of rows (4-16): "
        options[:rows] = choose(4, 16)
      end
      @board = Board.new(options)
    end

    def init_name
      name = gets.chomp
      while @invalid_names.include?(name)
        print "\nPlease enter a different name: "
        name = gets.chomp
      end
      @invalid_names << name
      name
    end

    def choose(min, max)
      choice = gets.chomp.to_i
      until (min..max).cover?(choice)
        print "\nPlease enter a valid choice: "
        choice = gets.chomp.to_i
      end
      choice
    end

    def play_game
      @games << Game.new(@players, @board)
      @games.last.play
    end

    def process_game
      game = @games.last
      if game.winner.nil?
        @game_scores[:draws] += 1
      else
        @game_scores[game.winner.name] += 1
      end
    end

    def prompt_play_again
      print "\nPlay again? "
    end

    def respond_with_yes?
      response = gets.chomp.downcase
      responses = %w[y yes n no]
      until responses.include?(response)
        print "\nPlease enter 'yes' or 'no': "
        response = gets.chomp.downcase
      end

      %w[y yes].include?(response)
    end
  end
end
