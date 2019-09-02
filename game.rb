require_relative "board"
require "yaml"
require "remedy"

class Game
  include Remedy
  def initialize(size, bomb_count)
    raise "Bomb count must be larger than 0" if bomb_count <= 0
    raise "Bomb count too high for board" if bomb_count > (size ** 2)
    @board = Board.new(size, bomb_count)
    @board.seed_bombs(bomb_count)
    @image = @board.render
    self.listen
  end

  # def run
  #   while !end?
  #     self.listen

  #   end
  # end

  def listen
    Console.set_console_resized_hook! do
      draw
    end
    # create an interaction object to handle user input
    input = Interaction.new
    # call draw here because interaction blocks until it gets input
    draw
    while !end?
      input.loop do |key|
        @last_key = key
        case
          when key == "q"
            input.quit!
          when key == "\e[A"
            @board.current_coord[0] -= 1
          when key == "\e[B"
            @board.current_coord[0] += 1
          when key == "\e[C"
            @board.current_coord[1] += 1
          when key == "\e[D"
            @board.current_coord[1] -= 1
          when key == "\r"
            @board.flip_tile(@board.current_coord)
          else
            "invalid input!"
          end
          @image = @board.render
        draw
      end
    end
  end

  def header
    Header.new << "Minesweeper"
  end

  def content
    c = Partial.new
    c << 
    <<-CONTENT
    #{@image}
    #{@board.current_coord}
    CONTENT
    c
  end

  def footer
    Footer.new << "You pressed: #{@last_key}, #{@board.current_coord}"
  end

  def draw
    Viewport.new.draw content, Size([0,0]), header, footer
  end








  # def run
  #   while !end?
  #     @board.render
  #     input = get_input
  #     next if !valid_input?(input)
  #     if input == "mode"
  #       @board.toggle_flag_mode
  #     elsif input == "save"
  #       self.save_game
  #     elsif input == "load"
  #       self.load_game
  #     else
  #       pos = convert_coordinate(input)
  #       @board.flip_tile(pos)
  #     end
  #   end
  # end

  # def toggle_flag_mode
  #   @flag_mode = !@flag_mode
  #   sleep(2)
  # end

  # def get_input
  #     puts "*** 'save' to save game.  'load' to load game.  'mode' to toggle flag_mode. ***"
  #     print "Enter coordinate (e.g. a9): "
  #     input = gets.chomp
  # end

  # def valid_input?(input)
  #   return true if input == "mode"
  #   return true if input == "save"
  #   return true if input == "load"
  #   return true if @alpha.include?(input[0].upcase) && input[1..-1].to_i >= 0 && input[1..-1].to_i < (@board.size)
  #   puts "Invalid input!"
  #   sleep(2)
  #   false
  # end

  # def convert_coordinate(coordinate)
  #   col = @alpha.find_index(coordinate[0].upcase)
  #   row = coordinate[1..-1].to_i
  #   [row, col]
  # end

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

game = Game.new(9, 10)