#Define Winning Combos in a constant:
WIN_COMBINATIONS = [
  [0, 1, 2],
  [3, 4, 5],
  [6, 7, 8],
  [0, 3, 6],
  [1, 4, 7],
  [2, 5, 8],
  [0, 4, 8],
  [2, 4, 6]
]

# Display the current version of the board:
def display_board(board)
  puts " #{board[0]} | #{board[1]} | #{board[2]} "
  puts "-----------"
  puts " #{board[3]} | #{board[4]} | #{board[5]} "
  puts "-----------"
  puts " #{board[6]} | #{board[7]} | #{board[8]} "
end

# Converts user input to an array index:
def input_to_index(user_input)
  user_input.to_i - 1
end

# Updates the current board with a player move:
def move(board, index, player)
  board[index] = player
end

# Confirms if there is already a player token in a specified board position:
def position_taken?(board, index)
  if board[index] == "X" || board[index] == "O"
    true
  else
    false
  end
end

# Confirms the user move is valid:
def valid_move?(board, index)
  if index.between?(0,8) && !position_taken?(board, index)
    true
  else
    false
  end
end

# Activates one turn of TicTacToe:
def turn(board)
  puts "Please enter 1-9:"

  user_input = gets.chomp
  index = input_to_index(user_input)

  if valid_move?(board, index)
    move(board, index, current_player(board))
    display_board(board)
  else
    turn(board)
  end
end

# Keeps track of how many total turns have been played:
def turn_count(board)
  board.count { |token| (token == "X" || token == "O")}
end

# Tracks who's turn it is:
def current_player(board)
  if turn_count(board) % 2 == 0
    return "X"
  else
    return "O"
  end
end

# Checks to see if a player wins:
def won?(board)
  WIN_COMBINATIONS.each do | win_combo |
    if win_combo.all? { |index| board[index] == "X"} || win_combo.all? { |index| board[index] == "O"}
      return win_combo
    end
  end
  false
end

# Checks to see if the board is full:
def full?(board)
  if turn_count(board) == board.length
    true
  else
    false
  end
end

# Checks to see if the game is a draw:
def draw?(board)
  if full?(board) && !won?(board)
    true
  else
    false
  end
end

# Checks to see if the game is over:
def over?(board)
  if won?(board) || draw?(board)
    true
  else
    false
  end
end

# Returns the winning player token:
def winner(board)
  winner = won?(board) #loads winning array into variable 'winner'
  if winner
    return board[winner[0]]
  end
  nil
end

# Main method in charge of running game play:
def play(board)
  if !over?(board)
    turn(board)
    play(board)
  elsif won?(board)
    puts "Congratulations #{winner(board)}!"
  else
    puts "Cat's Game!"
  end
end
