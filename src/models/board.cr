require "granite_orm/adapter/pg"

class Board < Granite::ORM::Base
  adapter pg
  table_name boards

  has_many :pieces
  belongs_to :game

  field title : String
  # id : Int64 primary key is created for you
  timestamps

  def initialize_pieces(game)
    self.save
    self.game = game 
    @title = "Game Board"
    
    initialize_pawns(true)
    initialize_pawns(false)

    self.save
    self
  end

  def initialize_pawns(color)
    y = color ? 1 : 6
    (0..8).each do |i|
      new_pawn = Piece.new(name: "pawn", color: color)
      new_pawn.x = i
      new_pawn.y = y
      new_pawn.board = self
      new_pawn.save
    end
  end

end

