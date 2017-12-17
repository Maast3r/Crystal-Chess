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

  @letter_to_num = {
    "a": 0, "b": 1, "c": 2, "d": 3,
    "e": 4, "f": 5, "g": 6, "h": 7
  }

  def initialize_pieces(game : Game) : Nil
    self.save
    self.game = game 
    @title = "Game Board"
    
    # Since granite doesn't support STI and we can't get jennifer to work
    # with amber, we're going to crudely make pieces like this for now

    initialize_pawns

    initialize_other_pieces("R", [0, 7])
    initialize_other_pieces("N", [1, 6])
    initialize_other_pieces("B", [2, 5])
    initialize_other_pieces("K", [3])
    initialize_other_pieces("Q",[4])
  end

  def create_piece(name : String, color : Bool, x : Int32, y : Int32) : Nil
    piece = Piece.new(name: name, color: color, x: x, y: y, taken: false)
    piece.board = self
    piece.save
  end

  def initialize_pawns : Nil
    (0..7).each do |y|
      create_piece("P", true, @row_white+1, y)
      create_piece("P", false, @row_black-1, y)
    end
  end

  def initialize_other_pieces(name : String, y_positions : Array(Int32)) : Nil
    y_positions.each do |y|
      create_piece(name, true, @row_white, y)
      create_piece(name, false, @row_black, y)
    end
  end

  #
  # Move formats follow normal chess notation (Qe4)
  # pawns don't normally get a letter in normal chess notation,
  # but it is easier to code with it in. we can remove it in the front-end
  # We can also eventually use valid move for an endpoint that sends a specific piece with
  # the new x and y so we support both inputs
  #
  def parse_move(move : String) : Piece | Nil
    name, new_x, new_y  = move.split("")
    @pieces.each do |piece|
      return piece if piece.name == name && valid_move?(piece, new_x, new_y)
    end 
    return nil
  end

  def valid_move?(piece : Piece, new_x : String, new_y : String) : Bool
    # try to dyanmically check valid piece placement 
    # or write the rules in a library module?
  end

end

