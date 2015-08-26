require_relative "./lib/four_score.rb"

class App
  def initialize
    @invalid_names = [""]
    @players = []
    @games = []
    @game_scores = Hash.new(0)
  end

  def init
    put_welcome
    get_players
    while true
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
      puts "Welcome to FourScore!"
      puts
    end

    def put_goodbye
      puts
      puts "Thanks for playing FourScore!"
    end

    def put_statistics
      puts
      puts "TOTAL GAMES: #{@games.count}"
      puts "  #{@game_scores[:draws]} draws"

      player1, player2 = @players.first.name, @players.last.name
      wins1, wins2 = @game_scores[player1], @game_scores[player2]

      puts "  #{wins1} win#{"s" unless wins1 == 1} for #{player1}"
      puts "  #{wins2} win#{"s" unless wins2 == 1} for #{player2}"
    end

    def get_players
      print "Enter first player: "
      @players << FourScore::Player.new(name: get_name, token: "X")
      puts
      print "Enter second player: "
      @players << FourScore::Player.new(name: get_name, token: "O")
    end

    def make_board
      puts
      print "Play with a (1) standard or (2) custom board: "
      board_choice = get_choice(1, 2)

      options = {}
      if board_choice == 2
        puts
        print "Number of columns (4-16): "
        options[:columns] = get_choice(4, 16)
        puts
        print "Number of rows (4-16): "
        options[:rows] = get_choice(4, 16)
      end
      @board = FourScore::Board.new(options)
    end

    def get_name
      name = gets.chomp
      while @invalid_names.include?(name)
        print "Please enter a different name: "
        name = gets.chomp
      end
      @invalid_names << name
      name
    end

    def get_choice(min, max)
      choice = gets.chomp.to_i
      until (min..max).include?(choice)
        print "Please enter a valid choice: "
        choice = gets.chomp.to_i
      end
      choice
    end

    def play_game
      @games << FourScore::Game.new(@players, @board)
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
      puts
      print "Play again? "
    end

    def respond_with_yes?
      ['y', 'yes'].include?(gets.chomp.downcase)
    end
end

App.new.init
