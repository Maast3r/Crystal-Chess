class Pawn < AbstractPiece
  def get_max_row_distance : Int32
    max_distance = 1
    max_distance = 2 if @piece.color && @piece.y.as(Int32) == 1
    max_distance = 2 if !@piece.color && @piece.y.as(Int32) == 6
    return max_distance
  end

  def valid_move?(column : Int32, row : Int32)
    max_row_distance = get_max_row_distance
    column_difference = (column-@piece.x.as(Int32)).abs
    row_difference = (row-@piece.y.as(Int32)).abs
    valid_column_move = column_difference == 0 || column_difference == 1
    valid_row_move = 0 <= row_difference && row_difference <= max_row_distance

    if valid_column_move && valid_row_move
      @piece.x = column
      @piece.y = row
      @piece.save
    end
    return valid_column_move && valid_row_move
  end
end
