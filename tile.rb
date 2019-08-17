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

end