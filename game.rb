require './board.rb'
require './piece.rb'

MAX_ITER=1000


####################################################################################################
#
# Game - a game of tetris
#
# Encapsulates a game of tetris on a given board size for a given algorithm

class Game

  attr_reader :width, :height, :max_iter, :score, :iterations


  def initialize(width, height, algo, max_iter=MAX_ITER)
    raise "Invalid board dimenstions" if width <= 0 || height <= 0
    raise "Game algorithm must be callable" unless algo.respond_to? :call

    @width, @height, @algo, @max_iter = width, height, algo, max_iter
    
    @score = 0
    @iterations = 0

    @board = Board.new(@width, @height)
  end


  # runs the game until a maximum number of iterations is reached or the game ends
  def run!
    
    while @iterations < @max_iter
      @iterations += 1
      
      piece = Piece.random()

      begin
        x_coord = @algo.call(@board, piece)
      rescue Exception => e
        puts "Error executing AI algorithm"
        puts e.backtrace()
        raise e
      end        

      begin
        @score += @board.addPiece(piece, x_coord)
      rescue BoardOverflowError
        return
      end

    end
    
  end

  # TODO - implement
  def to_s
  end  


end
