require "crt"
require "http/client"
require "json"

def create_board : Nil
  board_height = (0.9 * Crt.y).to_i
  board_width = board_height * 2
  y_padding = (Crt.y - board_height) / 2
  x_padding = y_padding * 2 - 2
  game_window = Crt::Window.new(board_height, board_width, y_padding, x_padding) 

  if Crt.x < Crt.y
    board_height = (0.9 * Crt.x).to_i
    board_width = board_height / 2
    y_padding = (Crt.x - board_height) / 2
    x_padding = y_padding / 2 - 2
    game_window = Crt::Window.new(board_height, board_width, y_padding, x_padding) 
  end

  game_window.refresh

  squares = create_squares(game_window, board_height, board_width, y_padding, x_padding)
  game = get_game(game_window)
  
  loop do
    update_game_board(squares, game)
    a = game_window.getch
    puts a
    make_move if a == 13 # enter
    #sleep 5
  end
end

def create_squares(game_window : Crt::Window, board_height : Int32, board_width : Int32, y_padding : Int32, x_padding : Int32) : Array(Array(Crt::Window))
  square_height = (board_height/8).to_i
  square_width = (board_width/8).to_i
  y_labels = ["8", "7", "6", "5", "4", "3", "2", "1"]
  x_labels = ["a", "b", "c", "d", "e", "f", "g", "h"]
  i = 0
  squares = [] of Array(Crt::Window)

  loop do
    squares << [] of Crt::Window
    j = 0
    loop do
      square = Crt::Window.new(square_height, square_width, y_padding+(i*square_height), 2 + x_padding+(j*square_width))
      background = (i+j) % 2 == 0 ? Crt::Color::Blue : Crt::Color::Cyan
      square.set_background(Crt::ColorPair.new(Crt::Color::White, background))
      square.refresh
      squares[i] << square

      j += 1
      break if j == 8
    end

    game_window.print(square_height/2 + square_height*i, 0, y_labels.reverse[i])
    game_window.print(square_height*8, 2+square_width/2 + square_width*i, x_labels.reverse[i])

    i += 1
    break if i == 8
  end
  game_window.refresh

  return squares
end

def get_game(game_window : Crt::Window) : JSON::Any
  response = HTTP::Client.get "http://localhost:3000/game"
  json_response = JSON.parse(response.body)
  return json_response
end

def update_game_board(squares : Array(Array(Crt::Window)), game : JSON::Any) : Array(Array(Crt::Window))
  squares.each do |row|
    row.each do |square|
      square.print(square.row/2, square.col/2, "")
    end
  end

  game["pieces"].each do |piece|
    color = piece["color"].as_bool ? Crt::Color::White : Crt::Color::Black
   background = (piece["x"].as_i + piece["y"].as_i) % 2 == 0 ? Crt::Color::Blue : Crt::Color::Cyan
   square = squares[piece["x"].as_i][piece["y"].as_i]
   square.set_background(Crt::ColorPair.new(color, background))
   square.print(square.row/2, square.col/2, piece["name"].as_s)
   square.refresh
  end
  return squares
end

def make_move
  puts "make move"
  response = HTTP::Client.post("http://localhost:3000/move", headers: nil, body: "asdf")
  json_response = JSON.parse(response.body)
  puts json_response 
end

Crt.init
Crt.start_color
Crt.cbreak
Crt.notimeout(true)
create_board
Crt.done

