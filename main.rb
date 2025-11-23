# hangman game to choose a word from .txt doc on start of game
# user to get 10 guesses. 
# each guess to be 1 lower case letter
# store all guessed letters to be displayed after guess
# show correct letters in correct position
# if word guess finish game
# if all guesses used and word not guessed, finish game.
require './dictionary'
require './board'
require 'yaml'

def play_game(board)

  board.show_lives
  board.show_board
  board.show_wrong_guesses

  while !board.finished?
    result = play_round(board)
    return if result == :save
  end

  result = board.finished?
  puts
  puts 'Game Finished'
  puts "You #{result}"
  puts
  puts "The word was #{board.answer}"

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
  puts 'Type your guess: (or "save")'
  guess = gets.chomp.downcase
  puts
  
  if guess == 'save'
    File.write('save.yaml', YAML.dump(board))
    puts 'Game saved!'
    return :save
  end

  valid?(guess, board)
end

def valid?(guess, board)
  while !guess.match?(/\A[a-z]\Z/) || !board.valid?(guess)
    puts "Try again: "
    guess = gets.chomp.downcase
  end

  guess
end

def new_game
dictionary = Dictionary.new
word = dictionary.get_word
board = Board.new(word)
board
end

def start
  loop do 
    puts 'Play new game? (y/n)'
    input = gets.chomp.downcase

    if input == 'n'
      puts
      puts "load game? (y/n)"
      input = gets.chomp.downcase

      if input == 'y'
        input = ' '
        board = YAML.safe_load_file(
          'save.yaml',
          permitted_classes: [Board]
          )
        play_game(board)
      else 
        break
      end
    end

    play_game(new_game) if input == 'y'
  end
end

start