class HangpersonGame

  # add the necessary class methods, attributes, etc. here
  # to make the tests in spec/hangperson_game_spec.rb pass.

  # Get a word from remote "random word" service

  # def initialize()
  # end

  attr_accessor :word, :guesses, :wrong_guesses

  def initialize(word)
    @word = word
    @guesses = ""
    @wrong_guesses = ""
  end

  def guess(letter)
    raise ArgumentError if letter !~ /[a-z]+/i

    letter = letter.downcase
    return false if @guesses.include? letter or @wrong_guesses.include? letter

    if @word.include? letter
      @guesses << letter
    else
      @wrong_guesses << letter
    end

    true
  end

  def word_with_guesses
    result = ""

    @word.each_char { |c|
      if @guesses.include? c
        result += c
      else
        result += "-"
      end
    }

    result
  end

  def check_win_or_lose
    return :lose if @wrong_guesses.length >= 7
    return :play if word_with_guesses.include? "-"
    :win
  end

  def self.get_random_word
    require 'uri'
    require 'net/http'
    uri = URI('http://watchout4snakes.com/wo4snakes/Random/RandomWord')
    Net::HTTP.post_form(uri ,{}).body
  end

end
