require "granite_orm/adapter/pg"

class Board < Granite::ORM::Base
  adapter pg
  table_name boards

  has_many :pieces
  belongs_to :game

  field title : String
  # id : Int64 primary key is created for you
  timestamps

  @row_white = 0
  @row_black = 7

  def initialize_pieces(game) : Nil
    self.save
    self.game = game 
    @title = "Game Board"
    
    initialize_pawns()

    initialize_pair_pieces("rook", [0, 7])
    initialize_pair_pieces("knight", [1, 6])
    initialize_pair_pieces("bishop", [2, 5])

    initialize_power_pieces("king", 3)
    initialize_power_pieces("queen", 4) 
  end

  def create_piece(name, color, x, y)
    piece = Piece.new(name: name, color: color, x: x, y: y)
    piece.board = self
    piece.save
  end

  def initialize_pawns() : Nil
    (0..7).each do |i|
      create_piece("pawn", true, @row_white+1, i)
      create_piece("pawn", false, @row_black-1, i)
    end
  end

  def initialize_pair_pieces(name : String, y_positions : Array(Int32)) : Nil
    y_positions.each do |y|
      create_piece(name, true, @row_white, y)
      create_piece(name, false, @row_black, y)
    end
  end

  def initialize_power_pieces(name : String, y_position : Int32) : Nil
    create_piece(name, true, @row_white, y_position)
    create_piece(name, false, @row_black, y_position)
  end

end

