#Player Class Pseudocode
# Input: Player Name, Player Symbol

#Board Class Pseudocode


#Game Class Pseudocode
#Input: Board, Players, Turn Order




require_relative "game-view.rb"

class Game
  
  include GameView

  def initialize
    @board = ["0", "1", "2", "3", "4", "5", "6", "7", "8"]
    @computer = "X"
    @human = "O"
  end

  def start_game
    welcome_message_display
    board_display
    user_input_message
    until game_is_over?(@board) || tie?(@board)
      if get_human_spot && !game_is_over?(@board) && !tie?(@board)
        eval_board 
      end     
      board_display
      user_input_message if !game_is_over?(@board)
    end
    puts "It's a draw!" if tie?(@board)
    puts "It's a draw!" if game_is_over?(@board)

  end

  def get_human_spot
    spot = nil
    until spot
      spot = gets.chomp
      if spot =~ /[0-8]/ && spot.length == 1
        location = spot.to_i
        if @board[location] != "X" && @board[location] != "O"
          @board[location] = @human
          return true
        else
          spot = nil
        end
      end
    end
  end

  def eval_board
    spot = nil
    until spot
      if @board[4] == "4"
        spot = 4
        @board[spot] = @computer
      else
        spot = get_best_move(@board, @computer)
        if @board[spot] != "X" && @board[spot] != "O"
          @board[spot] = @computer
        else
          spot = nil
        end
      end
    end
  end

  def get_best_move(board, next_player)
    available_spaces = []
    best_move = nil
    board.each do |s|
      if s != "X" && s != "O"
        available_spaces << s
      end
    end

    available_spaces.each do |space|
      #Winning Move
      board[space.to_i] = @computer
      if game_is_over?(board)
        best_move = space.to_i
        board[space.to_i] = space
        return best_move
      else
        #Blocking Move
        board[space.to_i] = @human
        if game_is_over?(board)
          best_move = space.to_i
          board[space.to_i] = space
          return best_move
        else
          board[space.to_i] = space
        end
      end
    end
    if best_move
      return best_move
    else
      #Random Move
      if @board[4] == "O"
        random_corner_spot = [0, 2, 6, 8].sample
        return random_corner_spot
      elsif @board[0] == "O" && @board[8] == "8"
        @board[8].to_i
      elsif @board[2] == "O" && @board[6] == "6"
        @board[6].to_i
      elsif @board[6] == "O" && @board[2] == "2"
        @board[2].to_i
      elsif @board[8] == "O" && @board[0] == "0"
        @board[0].to_i
      elsif @board[4] == "X"
        random_edge_spot = [1, 3, 5, 7].sample
        return random_edge_spot
      else
        n = rand(0..available_spaces.count)
        return available_spaces[n].to_i
      end
    end
  end

  def game_is_over?(board)

    [board[0], board[1], board[2]].uniq.length == 1 ||
    [board[3], board[4], board[5]].uniq.length == 1 ||
    [board[6], board[7], board[8]].uniq.length == 1 ||
    [board[0], board[3], board[6]].uniq.length == 1 ||
    [board[1], board[4], board[7]].uniq.length == 1 ||
    [board[2], board[5], board[8]].uniq.length == 1 ||
    [board[0], board[4], board[8]].uniq.length == 1 ||
    [board[2], board[4], board[6]].uniq.length == 1
      
  end

  def tie?(board)
    board.all? { |s| s == "X" || s == "O" }
  end

end

game = Game.new
game.start_game
