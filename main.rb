# hangman game to choose a word from .txt doc on start of game
# user to get 10 guesses. 
# each guess to be 1 lower case letter
# store all guessed letters to be displayed after guess
# show correct letters in correct position
# if word guess finish game
# if all guesses used and word not guessed, finish game.
require './dictionary'
require './board'

def play_game
  dictionary = Dictionary.new
  word = dictionary.get_word
  current_board = Board.new(word)

  current_board.show_lives
  current_board.show_board
  current_board.show_wrong_guesses

  while !current_board.finished?
    play_round(current_board)
  end

  result = current_board.finished?
  puts
  puts 'Game Finished'
  puts "You #{result}"
  puts
  puts "The word was #{word}"

end

def play_round(board)
  guess = user_guess(board)
  board.guess(guess)
  board.check_guess

  board.show_lives
  board.show_board
  board.show_wrong_guesses
end

def user_guess(board)
  puts
  puts 'Type your guess: '
  guess = gets.chomp.downcase
  puts
  
  valid?(guess, board)
end

def valid?(guess, board)
  while !guess.match?(/\A[a-z]\Z/) || !board.valid?(guess)
    puts "Try again: "
    guess = gets.chomp.downcase
  end

  guess
end

def start
  loop do 
    puts 'Play new game? (y/n)'
    input = gets.chomp.downcase

    break if input == 'n'

    play_game if input == 'y'
  end
end

start