require_relative "board"

class Game
  def initialize(size, bomb_count)
    @board = Board.new(size, bomb_count)
    @board.seed_bombs(bomb_count)
    self.run
  end

  def run
    while !self.end?
      @board.render
      pos = request_coordinate
      @board.flip_tile(pos)
    end
  end

  def request_coordinate
    print "Select a square's coordinate: "
    coordinate = gets.chomp
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

game = Game.new(9, 5)
