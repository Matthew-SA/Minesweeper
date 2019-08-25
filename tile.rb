require "colorize"
class Tile

  attr_reader :hidden, :flag, :bomb
  def initialize
    @value = 0
    @hidden = true
    @bomb = false
    @flag = false
    @colors = {
      1 => "1".light_blue,
      2 => "2".light_green,
      3 => "3".magenta,
      4 => "4".cyan,
      5 => "5".blue,
      6 => "6".green,
      7 => "7".light_magenta,
      8 => "8".magenta,
    }
  end

  def to_s
    if @flag
      "P".yellow
    elsif @hidden
      "☐"
    elsif @bomb
      "X".red
    else
      @value == 0 ? " " : @colors[@value]
    end
  end

  def empty?
    @value == 0
  end

  def increment_val
    @value += 1
  end


  def seed_bomb
    @bomb = true
  end

  def reveal
    @hidden = false
  end

  def toggle_flag
    @flag = !@flag
  end

end