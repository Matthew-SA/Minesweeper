require_relative "tile.rb"

class Board
  def initialize(size, bomb_count)
    @size = size
    @grid = Array.new(size) { Array.new(size) { Tile.new }}
    @bomb_count = bomb_count
  end

  def render
    system("clear")
    puts " Minesweeper "
    puts "+" + ("-" * (2 * @size - 1)) + "+"
    @grid.each do |row|
      print "|"
      row.each do |tile|
        print tile.to_s
        print "|"
      end
      puts 
    end
    puts "+" + ("-" * (2 * @size - 1)) + "+"
  end




end

game = Board.new(8, 3)
game.render