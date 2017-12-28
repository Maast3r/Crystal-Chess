abstract class AbstractPiece
  def initialize(@@piece : Piece)
  end
  
  abstract def valid_move?(column : Int32, row : Int32)
end

