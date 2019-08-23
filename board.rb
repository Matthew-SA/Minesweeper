require_relative "tile.rb"
require "byebug"
class Board
  attr_reader :safe_tiles, :triggered_bomb, :flag_mode

  def initialize(size, bomb_count)
    @alpha = ("A"..("A".ord + size).chr).to_a
    @size = size
    @grid = Array.new(size) { Array.new(size) { Tile.new }}
    @safe_tiles = size * size - bomb_count
    @triggered_bomb = false
    @flag_mode = false
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
    row = pos[0]
    col = pos[1]
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
      self[n_pos].increment_val
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
    return tile.toggle_flag if @flag_mode && tile.hidden
    return if tile.flag
    return @triggered_bomb = true if tile.bomb
    if tile.hidden && !tile.flag
      tile.reveal
      @safe_tiles -= 1
      if tile.empty?
        neighbors = find_neighbors(pos)
        neighbors.each do |n_pos|
          flip_tile(n_pos)
        end
      end
    end
  end

  def toggle_flag_mode
    @flag_mode = !@flag_mode
  end

  def reveal_bombs
    @grid.each do |row|
      row.each do |tile|
        tile.reveal if tile.bomb
      end
    end
  end

  def [](pos)
    row = pos[0].to_i
    col = pos[1].to_i
    @grid[row][col]
  end

  def []=(pos, value)
    row = pos[0].to_i
    col = pos[1].to_i
    @grid[row][col] = value
  end

end
