class Tile
  
  attr_reader :bomb
  def initialize
    @value = 0
    # @hidden = true
    @bomb = false
    # @flag = false
  end

  def to_s
    if @bomb
      "X"
    elsif @value == 0
      " "
    elsif @bomb
      "X"
    elsif @hidden
      @value
    else
      @value
    end
  end

  def increment
    @value += 1
  end

  def seed_bomb
    @bomb = true
  end

end