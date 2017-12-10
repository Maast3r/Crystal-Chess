require "granite_orm/adapter/pg"

class Board < Granite::ORM::Base
  adapter pg
  table_name boards

  has_many :pieces
  belongs_to :game

  field title : String
  # id : Int64 primary key is created for you
  timestamps
end

