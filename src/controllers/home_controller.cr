class HomeController < ApplicationController
  def index
    profile = Profile.new(name: "profile")
    profile.save

    game_test = Game.new(name: "Game")
    game_test = game_test.initialize_new_game(profile, profile)

    puts game_test.boards
    puts game_test.inspect
    puts game_test.boards[0].pieces

    render("index.slang")
  end
end

