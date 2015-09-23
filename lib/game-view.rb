module GameView

  def welcome_message_display
     puts "Welcome to my Tic Tac Toe game"
  end

  def board_display
     puts "|_#{@board.spaces[0]}_|_#{@board.spaces[1]}_|_#{@board.spaces[2]}_|\n|_#{@board.spaces[3]}_|_#{@board.spaces[4]}_|_#{@board.spaces[5]}_|\n|_#{@board.spaces[6]}_|_#{@board.spaces[7]}_|_#{@board.spaces[8]}_|\n"
  end

  def user_input_message
    puts "Please select your spot."
  end
  
  def game_over_message
    puts "Game over"
  end
  
end