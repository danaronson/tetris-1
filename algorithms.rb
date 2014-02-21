# default algorithm for placing 2x2 pieces in a row
def algo_2x2(board, piece)
  idx = 0

  while(board.at(board.height - 1, idx))
    idx += 2

    if idx > board.width - 2
      idx = 0
      break
    end
  end

  return idx
end
