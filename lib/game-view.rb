module GameView

  def welcome_message_display
     puts "Welcome to my Tic Tac Toe game"
  end

  def board_display
     puts "|_#{@board[0]}_|_#{@board[1]}_|_#{@board[2]}_|\n|_#{@board[3]}_|_#{@board[4]}_|_#{@board[5]}_|\n|_#{@board[6]}_|_#{@board[7]}_|_#{@board[8]}_|\n"
  end

  def user_input_message
    puts "Please select your spot."
  end
  
  def game_over_message
    puts "Game over"
  end
  
end