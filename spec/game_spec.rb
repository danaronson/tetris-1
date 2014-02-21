require_relative "../game.rb"
require_relative "../algorithms.rb"

describe Game do

  it "should instantiate" do
    expect(Game.new(10, 10, method(:algo_2x2))).to be_a Game
  end


  it "should fail to instantiate with bad args" do
    expect {Game.new(-7, 0, method(:algo_2x2))}.to raise_error
    expect {Game.new(10, 10, "blargh")}.to raise_error
  end


  it "should get max score with 2x2 algo & even width board" do
    game = Game.new(10, 10, method(:algo_2x2))

    max_score = game.max_iter / 5 * 2

    game.run!

    expect(game.score).to eq(max_score)
    expect(game.iterations).to eq(game.max_iter)

  end

end
