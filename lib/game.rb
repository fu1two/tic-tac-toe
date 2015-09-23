#Player Class Pseudocode
# Input: Player Name, Player Symbol
# Shoud have knowledge of:
# 

#Board Class Pseudocode
# Hold space indices array
# Should have knowledge of:
# What spaces are left.

#Game Class Pseudocode
#Input: Board, Players, Turn Order


require_relative "game-view.rb"
require_relative "player.rb"
require_relative "board.rb"

class Game
  
  include GameView

  attr_reader :computer, :human
  attr_accessor :board

  def initialize(board)
    @board = board
    @player2 = "X"
    @player1 = "O"
  end

  def play_game
    welcome_message_display
    board_display
    user_input_message
    until game_is_over?(@board.spaces) || tie?(@board.spaces)
      if get_human_spot && !game_is_over?(@board.spaces) && !tie?(@board.spaces)
        eval_board 
      end     
      board_display
      user_input_message if !game_is_over?(@board.spaces)
      unless @board.open_spaces.count < 1
        puts "Open Spaces: #{@board.open_spaces}"
      end
    end
    puts "It's a draw!" if tie?(@board.spaces)
    puts "You lose!" if game_is_over?(@board.spaces)

  end

  def get_human_spot
    spot = nil
    until spot
      spot = gets.chomp
      if spot =~ /[0-8]/ && spot.length == 1
        location = spot.to_i
        if @board.spaces[location] != @player2 && @board.spaces[location] != @player1
          @board.spaces[location] = @player1
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
      if @board.spaces[4] == "4"
        spot = 4
        @board.spaces[spot] = @player2
      else
        spot = best_computer_move(@board.spaces)
        if @board.spaces[spot] != "X" && @board.spaces[spot] != "O"
          @board.spaces[spot] = @player2
        else
          spot = nil
        end
      end
    end
  end
  
  def find_available_spaces(board)
    spaces = []
    board.each do |s|
      if s != "X" && s != "O"
        spaces << s
      end
    end
    spaces
  end

  def find_computer_winning_move
    
  end

  def find_computer_blocking_move
    #Random Move
      if @board.spaces[4] == @player1
        random_corner_spot = [0, 2, 6, 8].sample
        return random_corner_spot
      elsif @board.spaces[0] == @player1 && @board.spaces[8] == "8"
        @board.spaces[8].to_i
      elsif @board.spaces[2] == @player1 && @board.spaces[6] == "6"
        @board.spaces[6].to_i
      elsif @board.spaces[6] == @player1 && @board.spaces[2] == "2"
        @board.spaces[2].to_i
      elsif @board.spaces[8] == @player1 && @board.spaces[0] == "0"
        @board.spaces[0].to_i
      elsif @board.spaces[4] == @player2
        random_edge_spot = [1, 3, 5, 7].sample
      else
          computer_random_move
      end
  end

  def computer_random_move
    n = rand(0..available_spaces.count)
    return available_spaces[n].to_i
  end

  def best_computer_move(board)
    best_move = nil
    available_spaces = find_available_spaces(board)
    available_spaces.each do |space|
      #Winning Move
      board[space.to_i] = @player2
      if game_is_over?(board)
        best_move = space.to_i
        board[space.to_i] = space
        return best_move
      else
        #Blocking Move
        board[space.to_i] = @player1
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
      find_computer_blocking_move
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
    board.all? { |s| s == @player2 || s == @player1 }
  end

end
board = Board.new
game = Game.new(board)
game.play_game
