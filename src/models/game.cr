require "granite_orm/adapter/pg"

class Game < Granite::ORM::Base
  adapter pg
  table_name games

  belongs_to :profile
  belongs_to :profile

  field name : String
  # id : Int64 primary key is created for you
  timestamps
end
