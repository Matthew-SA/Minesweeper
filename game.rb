require_relative "board"

class Game
  def initialize(size, bomb_count)
    @board = Board.new(size, bomb_count)
    @board.seed_bombs(bomb_count)
    @alpha = ("A".."Z").to_a
    self.run
  end

  def run
    while !self.end?
      @board.render
      pos = convert_coordinate(request_coordinate)
      p pos
      @board.flip_tile(pos)
      sleep(2)
    end
  end

  def request_coordinate
    print "Select a square's coordinate: "
    coordinate = gets.chomp
  end

  def convert_coordinate(coordinate)
    col = @alpha.find_index(coordinate[0].upcase)
    row = coordinate[1..-1].to_i
    [col, row]
  end

  def select_tile

  end

  def end?
    false
  end

  def won?

  end

  def lose?
    
  end
end

game = Game.new(9, 10)
