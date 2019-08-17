require_relative "tile.rb"

class Board
  def initialize(size, bomb_count)
    @grid = Array.new(size) { Array.new(size) { 0 }}
    @bomb_count = bomb_count
  end

  def render
    @grid.each do |row|
      p row
    end
  end




end

game = Board.new(9, 5)
game.render