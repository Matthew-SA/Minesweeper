require_relative "tile.rb"

class Board
  attr_reader :grid

  def initialize(size, bomb_count)
    raise "Board size too large" if size > 26
    @alpha = ("A".."Z").to_a
    @size = size
    @grid = Array.new(size) { Array.new(size) { Tile.new }}
    @bomb_count = bomb_count
  end


  def render
    system("clear")
    puts "    Minesweeper "
    puts "   +" + ("-" * (2 * @size - 1)) + "+"
    @grid.each_with_index do |row, row_idx|
      print row_idx < 10 ? " #{row_idx} |" : "#{row_idx} |" 
      row.each do |tile|
        print tile.to_s
        print "|"
      end
      puts 
    end
    puts "   +" + ("-" * (2 * @size - 1)) + "+"
    print "    "
    @size.times { |num| print @alpha[num] + " " }
    puts
  end

  def [](pos)
    col = @alpha.find_index(pos[0])
    row = pos[1].to_i
    p col
    p row
    p @grid[row][col]
  end

  def []=(pos, value)
    col = @alpha.find_index(pos[0])
    row = pos[1].to_i
    @grid[row][col].value = value
  end

end

game = Board.new(9, 3)
game.render
game["B0"] = 4
game["B0"]
