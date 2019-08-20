require_relative "board"
require_relative "tile"
class Game
  def initialize(size, bomb_count)
    raise "Bomb count must be larger than 0" if bomb_count <= 0
    @board = Board.new(size, bomb_count)
    @board.seed_bombs(bomb_count)
    @alpha = ("A".."Z").to_a
    self.run
  end

  def run
    while !end?
      @board.render
      pos = convert_coordinate(get_coordinate)
      @board.flip_tile(pos)
      sleep(2)
    end
  end

  def get_coordinate
    print "Select a square's coordinate: "
    coordinate = gets.chomp
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

game = Game.new(9, 2)