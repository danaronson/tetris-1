require_relative "../piece.rb"

describe Piece do

  it "should instantiate" do
    expect(Piece.new([[true]])).to be_a Piece
  end


  it "should fail to instantiate with bad args" do
    expect {Piece.new([[true], [nil, true]])}.to raise_error
  end


  it "should access correctly, given no rotation" do
    piece = Piece.new([[true, nil], [true, true]])
    grid = (0...2).map{|h| (0...2).map{|w| piece.at(h, w)}}

    expect(grid).to eq([[true, nil], [true, true]])

  end


  it "should access correctly, given rotation" do
    piece = Piece.new([[true, nil], [true, true]])
    piece.orientation = "E"
    grid = (0...2).map{|h| (0...2).map{|w| piece.at(h, w)}}

    expect(grid).to eq([[nil, true], [true, true]])

    piece.orientation = "N"
    grid = (0...2).map{|h| (0...2).map{|w| piece.at(h, w)}}

    expect(grid).to eq([[true, true], [nil, true]])

    piece.orientation = "W"
    grid = (0...2).map{|h| (0...2).map{|w| piece.at(h, w)}}

    expect(grid).to eq([[true, true], [true, nil]])
  end


  it "should have correct dimensions given no rotation" do
    piece = Piece.new([[true, true, true]])
    expect([piece.height, piece.width]).to eq([1, 3])
  end


  it "should have correct dimensions given rotation" do
    piece = Piece.new([[true, true, true]])
    piece.orientation = "E"

    expect([piece.height, piece.width]).to eq([3, 1])
  end

  
  it "should correctly test equality" do
    expect(Piece.new([[true]])).to eq(Piece.new([[true]]))
    expect(Piece.new([[true]])).not_to eq(Piece.new([[true, true]]))

    expect(Piece.new([[true]], 'E')).to eq(Piece.new([[true]]))
  end
  

end
