require "granite_orm/adapter/pg"

class Piece < Granite::ORM::Base
  adapter pg
  table_name pieces
  
  belongs_to :board

  field color : Bool
  field name : String
  field x : Int32
  field y : Int32
  field taken : Bool
  field points : Int32

  # id : Int64 primary key is created for you
  timestamps
end

