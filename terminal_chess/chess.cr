require "crt"

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

  #game_window.border
  game_window.refresh

  squares = create_squares(game_window, board_height, board_width, y_padding, x_padding)

  loop do
    a = game_window.getch
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
      square.set_background(Crt::ColorPair.new(Crt::Color::White, Crt::Color::Magenta)) if (i+j) % 2 == 1
      square.set_background(Crt::ColorPair.new(Crt::Color::Black, Crt::Color::Blue)) if (i+j) % 2 == 0
      square.print(square.row/2, square.col/2, "P")
      square.refresh
      squares[i] << square

      j += 1
      break if j == 8
    end

    game_window.print(square_height/2 + square_height*i, 0, y_labels[i])
    game_window.print(square_height*8, 2+square_width/2 + square_width*i, x_labels[i])

    i += 1
    break if i == 8
  end
  game_window.refresh

  return squares
end


Crt.init
Crt.start_color
create_board
Crt.done

