class Pawn < AbstractPiece
  @@moved = false

  def valid_move?(column : Int32, row : Int32)
    max_row_distance = @@moved ? 1 : 2
    column_difference = (column-@@piece.x).abs
    row_difference = (row-@@piece.y).abs
    valid_column_move = column_difference == 0 || column_difference == 1
    valid_row_move = 0 <= row_difference && row_difference <= max_row_distance
    if valid_column_move && valid_row_move
      @@moved = true
      @@piece.x = column
      @@piece.y = row
      @@piece.save
    end
    return valid_column_move && valid_row_move
  end
end
