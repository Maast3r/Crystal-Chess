require "crt"

def create_board : Nil
  board_height = (0.9 * Crt.y).to_i
  board_width = board_height * 2
  y_padding = (Crt.y - board_height) / 2
  x_padding = y_padding * 2
  game_window = Crt::Window.new(board_height, board_width, y_padding, x_padding) 

  if Crt.x < Crt.y
    board_height = (0.9 * Crt.x).to_i
    board_width = board_height / 2
    y_padding = (Crt.x - board_height) / 2
    x_padding = y_padding / 2
    game_window = Crt::Window.new(board_height, board_width, y_padding, x_padding) 
  end

  #game_window.border
  game_window.refresh

  create_squares(board_height, board_width, y_padding, x_padding)

  loop do
    a = game_window.getch
  end
end

def create_squares(board_height : Int32, board_width : Int32, y_padding : Int32, x_padding : Int32) : Nil
  square_height = (board_height/8).to_i
  square_width = (board_width/8).to_i
  i = 0
  squares = [] of Crt::Window
  loop do
    j = 0
    loop do
      square = Crt::Window.new(square_height, square_width, y_padding+(i*square_height), x_padding+(j*square_width))
      square.print(square.row/2, square.col/2, "P")
      square.border
      square.refresh
      squares << square
      j += 1
      break if j == 8
    end
    i += 1
    break if i == 8
  end
  return squares
end

Crt.init
create_board
Crt.done

