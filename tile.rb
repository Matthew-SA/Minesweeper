class Tile
  def initialize
    @value = 0
    @hidden = true
    @bomb = false
    @flag = false
  end

  def to_s
    @value
  end

  def increment
    @value += 1
  end

end