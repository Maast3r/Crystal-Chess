require "granite_orm/adapter/pg"

class Profile < Granite::ORM::Base
  adapter pg
  table_name profiles

  field name : String

  # id : Int64 primary key is created for you
  timestamps
end

