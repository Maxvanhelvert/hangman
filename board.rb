require 'yaml'

class Board
  attr_accessor :answer, :board, :life_num, :lives, :wrong_guesses

  def initialize(answer)
    @answer = answer
    @board = []
    set_board
    @life_num = 10
    @lives = []
    set_lives
    @wrong_guesses = []
    @guess = ''
  end

  def guess(guess)
    @guess = guess
  end

  def set_board
    @answer.each_char do |char|
      @board.push('-')
    end
    @board
  end

  def show_board
    @board.each do |char|
      print char
      print ' '
    end
    puts
  end

  def show_lives
    puts 'Lives: '
    @lives.each do |life|
      print life
      print ' '
    end
    puts
  end

  def show_wrong_guesses
    puts 'Wrong guesses: '
    @wrong_guesses.each do |guess|
      print guess
      print ' '
    end
    puts
  end

  def set_lives
    count = 0
    while count < @life_num do
      @lives.push('●')
      count += 1
    end
    @lives
  end

  def lose_life
    @lives[@life_num - 1] = 'X'

    @life_num -= 1

    @life_num
  end

  def wrong_guess
    @wrong_guesses.push(@guess)
    lose_life
  end

  def correct_guess
    temp_ans = @answer.split('')
    temp_ans.each_with_index do |char, i|
      @board[i] = @guess if char == @guess
    end
  end

  def check_guess
    if @answer.include?(@guess)
      correct_guess
    else
      wrong_guess
    end
  end

  def finished?
    game = false
    game = 'win' unless @board.include?('-') 
    game = 'lose' if @life_num <= 0
    game
  end

  def valid?(guess)
    true unless @board.include?(guess)
    true unless @wrong_guesses.include?(guess)
  end

  def answer
    @answer
  end
end