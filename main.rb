# hangman game to choose a word from .txt doc on start of game
# user to get 10 guesses. 
# each guess to be 1 lower case letter
# store all guessed letters to be displayed after guess
# show correct letters in correct position
# if word guess finish game
# if all guesses used and word not guessed, finish game.
require './dictionary'

def play_game
  dictionary = Dictionary.new
  word = dictionary.get_word
  p word
end

play_game