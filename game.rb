require_relative "board"
require "yaml"

class Game
  def initialize(size, bomb_count)
    raise "Bomb count must be larger than 0" if bomb_count <= 0
    raise "Bomb count too high for board" if bomb_count > (size ** 2)
    @board = Board.new(size, bomb_count)
    @board.seed_bombs(bomb_count)
    @alpha = ("A"..("A".ord + size).chr).to_a
    self.run
  end

  def run
    while !end?
      @board.render
      input = get_input
      next if !valid_input?(input)
      if input == "mode"
        @board.toggle_flag_mode
      elsif input == "save"
        self.save_game
      elsif input == "load"
        self.load_game
      else
        pos = convert_coordinate(input)
        @board.flip_tile(pos)
      end
    end
  end

  def toggle_flag_mode
    @flag_mode = !@flag_mode
    puts "worked"
    sleep(2)
  end

  def get_input
      puts "*** 'save' to save game.  'load' to load game.  'mode' to toggle flag_mode. ***"
      print "Enter coordinate (e.g. a9): "
      input = gets.chomp
  end

  def valid_input?(input)
    return true if "mode"
    return true if "save"
    return true if "load"
    return true if @alpha.include?(input[0]) && input[1..-1].to_i > 0 && input[1..-1].to_i < @size -1
    puts "Invalid input!"
    sleep(2)
    false
  end

  def convert_coordinate(coordinate)
    col = @alpha.find_index(coordinate[0].upcase)
    row = coordinate[1..-1].to_i
    [row, col]
  end

  def save_game
    File.open("saves.yml", "w") { |file| file.write(@board.to_yaml)}
    @board.render
    puts "GAME SAVED"
    sleep(2)
  end

  def load_game
    @board = YAML.load(File.read("saves.yml"))
    @board.render
    puts "GAME LOADED"
    sleep(2)
  end

  def end?
    self.won? || self.lose?
  end

  def won?
    if @board.safe_tiles <= 0
      @board.render
      puts "You win!"
      true
    end
  end

  def lose?
    if @board.triggered_bomb
      @board.reveal_bombs
      @board.render
      puts "You lose!"
      true
    end
  end
end

game = Game.new(10, 20)