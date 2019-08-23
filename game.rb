require_relative "board"

class Game
  def initialize(size, bomb_count)
    raise "Bomb count must be larger than 0" if bomb_count <= 0
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
        next
      else
        pos = convert_coordinate(input)
        @board.flip_tile(pos)
      end
        sleep(1)
    end
  end

  def toggle_flag_mode
    @flag_mode = !@flag_mode
  end

  def get_input
      print "Mode: "
      print @board.flag_mode ? "**Place flags**" : "**Reveal tiles**"
      puts
      print "Enter coordinate (e.g. a9) or type 'mode' to toggle selection behavior: "
      input = gets.chomp
  end

  def valid_input?(input)
    return true if "flag"
    return true if @alpha.include?(input) && input[1..-1].to_i > 0 && input[1..-1].to_i < @size -1
    puts "Invalid input!"
    false
  end

  def convert_coordinate(coordinate)
    col = @alpha.find_index(coordinate[0].upcase)
    row = coordinate[1..-1].to_i
    [row, col]
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

game = Game.new(9, 5)