require_relative "../board.rb"

describe Board do

  it "should instantiate" do
    expect(Board.new(10,10)).to be_a Board
  end


  it "should fail to instantiate with bad args" do
    expect {Board.new(-7, 0)}.to raise_error
  end


  context "as empty 3x3" do
    let(:board) { Board.new(3, 3) }
    let(:block) { Piece.block() }

    it "should forbid invalid placements" do
      expect {board.addPiece(block, board.width, block.width - 1)}.to raise_error
    end


    it "should add a block correctly" do
      board.addPiece(block, 0)

      grid = (0...3).map{|h| (0...3).map{|w| board.at(h, w)}}

      expect(grid).to eq([[nil, nil, nil], [true, true, nil], [true, true, nil]])
    end

   
    it "should overflow when necessary" do
      board.addPiece(block, 0)
      expect{board.addPiece(block, 1)}.to raise_error BoardOverflowError
    end
    
  end


  context "as empty 4x4" do
    let(:board) { Board.new(4, 4) }
    let(:block) { Piece.block() }
    let(:zig) { Piece.zig() }

    it "should stack 2 zigs correctly" do
      board.addPiece(zig, 0)
      board.addPiece(zig, 1)

      grid = (0...4).map{|h| (0...4).map{|w| board.at(h, w)}}

      expect(grid).to eq([[nil, true, nil, nil], [true, true, true, nil], [true, true, true, nil], [nil, true, nil, nil]])

    end


    it "should remove rows & score correctly" do
      score = board.addPiece(block, 0)
      expect(score).to eq(0)
      score = board.addPiece(block, 2)
      expect(score).to eq(2)

      grid = (0...4).map{|h| (0...4).map{|w| board.at(h, w)}}
      expect(grid).to eq([[nil, nil, nil, nil],[nil, nil, nil, nil],[nil, nil, nil, nil],[nil, nil, nil, nil]])
      
    end

  end

end
