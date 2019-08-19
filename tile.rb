class Tile

  attr_reader :bomb
  def initialize
    @value = 0
    @hidden = true
    @bomb = false
    @flag = false
  end

  def to_s
    if @hidden
      "☐"
    elsif @bomb
      "X"
    else
      @value == 0 ? " " : @value
    end
  end



  def increment
    @value += 1
  end

  def seed_bomb
    @bomb = true
  end

  def reveal
    @hidden = false
  end

end