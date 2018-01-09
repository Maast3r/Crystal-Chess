class PieceFactory
  def self.create_piece(name : String, piece : Piece) : AbstractPiece
    case name
    when "P"
      Pawn.new(piece: piece)
    when "R"
      Rook.new(piece: piece)
    when "N"
      Knight.new(piece: piece)
    when "B"
      Bishop.new(piece: piece)
    when "Q"
      Queen.new(piece: piece)
    when "K"
      King.new(piece: piece)
    else
      Pawn.new(piece: piece)
    end
  end
end

