class Dictionary
  
  def initialize
    @data = File.read('google-10000-english-no-swears.txt').split  
    @dictionary = []
    get_dictionary
  end

  def get_dictionary
    @data.each do |word|
      next if word.length < 4 || word.length > 12
    
      @dictionary.append(word)
    end
    @dictionary
  end

  def get_word
    @dictionary.sample
  end
end