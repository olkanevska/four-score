require_relative "./lib/four_score.rb"

class App
  def initialize
    @invalid_names = [""]
    @players = []
  end

  def put_welcome
    puts "Welcome to FourScore!"
    puts
  end

  def put_goodbye
    puts
    puts "Thanks for playing FourScore!"
  end

  def get_players
    print "Enter first player: "
    @players << FourScore::Player.new(name: get_name, token: "X")
    puts
    print "Enter second player: "
    @players << FourScore::Player.new(name: get_name, token: "O")
  end

  def get_board
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
    puts
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

  def prompt_play_again
    puts
    print "Play again? "
  end

  def respond_with_yes?
    ['y', 'yes'].include?(gets.chomp.downcase)
  end

  def init
    put_welcome
    get_players
    while true
      get_board
      FourScore::Game.new(@players, @board).play
      prompt_play_again
      break unless respond_with_yes?
    end
    put_goodbye
  end
end

App.new.init
