require "granite_orm/adapter/pg"

class Game < Granite::ORM::Base
  adapter pg
  table_name games

  belongs_to :profile
  belongs_to :profile
  has_many :boards

  field name : String
  # id : Int64 primary key is created for you
  timestamps

  def initialize_new_game(player1, player2) : Nil
    self.save
    self.profile = player1

    board = Board.new(title: "Chess game")
    board.game = self 
    board.initialize_pieces(self)
    self.save
  end

  def board
    boards.first
  end

end

