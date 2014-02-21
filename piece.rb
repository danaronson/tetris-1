####################################################################################################
#
# Piece - a representation of a tetris piece
#
# Stored as an x-y grid with an orientation.  Stores either nil or true if the piece occupies that location
# (0,0) is upper left, and the first corrdinate is height

class Piece

  def initialize(grid, orientation = 'S')
    if(grid.class != Array ||
       grid.map{|r| r.class != Array}.any? ||
       grid.map{|r| r.size}.uniq.size != 1)
      raise 'invalid grid'
    end

    @grid, @orientation = grid, orientation

    @height = grid.size
    @width = grid.first.size
  end


  def orientation=(orientation)
    raise 'invalid orientation' unless ['S', 'E', 'N', 'W'].include?(orientation)

    @orientation = orientation
  end

  
  def to_s
    @grid.map{|row| row.map{|elt| elt ? '*' : '.'}.join()}.join("\n")
  end


  # test equailty. Note - ignores orientation
  def ==(obj)
    obj.grid == @grid
  end


  # give the correct width, given the orientation
  def width
    ['N', 'S'].include?(@orientation) ? @width : @height
  end


  # give the correct height, given the orientation
  def height
    ['N', 'S'].include?(@orientation) ? @height : @width
  end


  # get square of a piece at a given location, taking into account orientation
  def at(h, w)
    raise "width outside of range" if w < 0 || w >= width
    raise "height outside of range" if h < 0 || h >= height

    case @orientation
    when 'N'
      w = width - 1 - w
      h = height - 1 - h
    when 'E'
      w, h = height - 1 - h, w
    when 'W'
      w, h = h, width - 1 - w
    end

    return @grid[h][w]
  end

  # accessible to other Pieces only - used to test equality
  protected

  def grid
    @grid
  end

  public


  ####################################################################################################
  #
  # Class Methods
  #

  # gets a random piece in a random orientation
  # TODO - right now always returns a block
  def self.random()
    piece = [Piece.block(), Piece.bar(), Piece.zig(), Piece.zig_mirror(), Piece.L(), Piece.L_mirror(), Piece.T()].take(1).sample  #TODO - remove .take(1)
    piece.orientation = ['S', 'E', 'N', 'W'].sample

    return piece
  end

  # Default shapes

  def self.block()
    Piece.new([[true,true],[true,true]])
  end

  def self.bar()
    Piece.new([[true],[true],[true],[true]])
  end

  def self.zig()
    Piece.new([[true,nil],[true,true],[nil,true]])
  end

  def self.zig_mirror()
    Piece.new([[nil,true],[true,true],[true,nil]])
  end

  def self.L()
    Piece.new([[true,nil],[true,nil],[true,true]])
  end

  def self.L_mirror
    Piece.new([[nil,true],[nil,true],[true,true]])
  end

  def self.T()
    Piece.new([[true, true, true], [nil, true, nil]])
  end
 
end
