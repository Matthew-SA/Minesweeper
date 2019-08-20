require_relative "tile.rb"
require "byebug"
class Board
  attr_reader :grid

  def initialize(size, bomb_count)
    raise "Board size too large" if size > 26
    @alpha = ("A".."Z").to_a
    @size = size
    @grid = Array.new(size) { Array.new(size) { Tile.new }}
    @bomb_count = bomb_count
  end

  def seed_bombs(bombs)
    while bombs > 0
      row = rand(@size)
      col = rand(@size)
      selected_tile = @grid[row][col]
      if !selected_tile.bomb
        selected_tile.seed_bomb
        increment_adjacent([row,col])
        bombs -= 1
      end
    end
  end

  def find_neighbors(pos)
    col = pos[0]
    row = pos[1]
    neighbors = []
    (row-1..row+1).each do |y|
      next if y < 0 || y >= @size
      (col-1..col+1).each do |x|
        next if x < 0 || x >= @size
        neighbors << [y,x]
      end
    end
    neighbors
  end

  def increment_adjacent(pos)
    neighbors = find_neighbors(pos)
    neighbors.each do |n_pos|
      self[n_pos].increment
    end
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

  def flip_tile(pos)
    tile = self[pos]
    if tile.hidden && !tile.flag
      tile.reveal
    # neighbors = find_neighbors(row, col)
    # neighbors.each do |neighbor_pos|
    #   neighbor_pos.reveal
    end
  end

  def [](pos)
    col = pos[0].to_i
    row = pos[1].to_i
    @grid[row][col]
  end

  def []=(pos, value)
    col = pos[0].to_i
    row = pos[1].to_i
    @grid[row][col] = value
  end


  # def [](pos)
  #   col = @alpha.find_index(pos[0].upcase)
  #   row = pos[1].to_i
  #   @grid[row][col]
  # end

  # def []=(pos, value)
  #   col = @alpha.find_index(pos[0])
  #   row = pos[1].to_i
  #   @grid[row][col] = value
  # end

end
