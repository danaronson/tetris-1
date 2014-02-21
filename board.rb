class BoardOverflowError < StandardError; end

####################################################################################################
#
# Board - a tetris game board
#
# Stored as an x-y grid.  Stores either nil or true if the location is occupied
# (0,0) is upper left, and the first corrdinate is height


class Board

  attr_accessor :width, :height


  def initialize(width, height)
    raise "Invalid dimenstions" if width <= 0 || height <= 0

    @width, @height = width, height

    @grid = (0...@height).map{|_| (0...@width).map{|_| nil}}
  end


  # adds a piece to the board at a specific x coordinate for the leftmost column of the piece
  # removes filled rows at the bottom & returns the number of said rows
  def addPiece(piece, x_coord)
    raise "invalid coordinate" if x_coord < 0 || x_coord + piece.width > @width
    
    # first, compute width & height offsets where the upper left corner of the piece will go on the board
    w_ofs = x_coord

    # for each relevant column, compute the location of the uppermost filled square
    board_profile = (0...piece.width).map {|w| @grid.transpose[w_ofs + w].index(true) || @height} 

    # for each column, compute the location of the bottommost filled square(counting from the bottom)
    piece_profile = (0...piece.width).map do |w| 
      (0...piece.height).map{|h| piece.at(h, w)}.reverse.index(true) || 0
    end

    # get the max distance the piece can be lowered
    h_ofs = (0...piece.width).map{|i| board_profile[i] + piece_profile[i]}.min - piece.height

    # Example of above algorithm:
    #
    # 101  <- piece profile
    # ---
    # ***  <- piece
    # .*.
    # ---  <- start of game board
    # ...
    # ...
    # *..
    # *..
    # *..
    # ***
    # ---
    # 255 <- board profile
    # 356 <- board + piece profile
    # 3   <- # of squares piece can be lowered

    if h_ofs < 0
      raise BoardOverflowError
    end

    # place piece
    (0...piece.width).each do |w|
      (0...piece.height).each do |h|
        @grid[h_ofs + h][w_ofs + w] ||= piece.at(h, w)
      end
    end      

    return scoreRows!()
  end


  def to_s
    @grid.map{|row| row.map{|elt| elt ? '*' : '.'}.join()}.join("\n")
  end

  
  def at(h, w)
    @grid[h][w]
  end


  private

  # finds & removes filled rows at the bottom of the grid.  returns number of rows removed
  def scoreRows!()

    score = 0

    while(@grid[@height - 1].all?)
      (@height - 1).downto(1).each do |h|
        (0...@width).each do |w|
          @grid[h][w] = @grid[h - 1][w]
        end
      end

      score += 1
    end

    return score
  end

end
