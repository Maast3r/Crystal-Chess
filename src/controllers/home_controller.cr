class HomeController < ApplicationController
  def index
    profile = Profile.new(name: "profile")
    profile.save

    game_test = Game.new(name: "Game")
    game_test.initialize_new_game(profile, profile)

    puts game_test.board
    puts game_test.inspect
    puts game_test.board.pieces

    render("index.slang")
  end
  
  def game
    game = Game.find(1).as Game
    return {"game": game, "board": game.board, "pieces": game.board.pieces}.to_json
  end

  def move
    puts "aasdfasdfasf"
    move = params["move"]
    game = Game.find(1).as Game
    game.board.parse_move(move)
    return {"game": game, "board": game.board, "pieces": game.board.pieces}.to_json
  end

  def movee
    puts "moveeeeeee"
  end
end

