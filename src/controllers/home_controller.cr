class HomeController < ApplicationController
  def index
    profile = Profile.new(name: "profile")
    puts profile.name
    profile.save
    piece = Piece.new(name: "piece")
    puts piece.name
    board = Board.new(title: "test")
    board.save
    piece.board = board
    piece.save
    
    a =  [1,2,3]
    a << 4
    puts a

    boards = Board.all
    boards.each do |board|
      puts board.pieces
    end

    render("index.slang")
  end
end

