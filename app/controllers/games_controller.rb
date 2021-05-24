class GamesController < ApplicationController
  def new
    @letters = []
    10.times { @letters << ('A'..'Z').to_a.sample }
  end

  def score
    @valid = guess_is_valid?(params[:guess], params[:letters])
    res = URI.open("https://wagon-dictionary.herokuapp.com/#{params[:guess]}").read
    @body = JSON.parse(res)
  end

  def guess_is_valid?(guess, letters)
    valid = true
    guess.chars.each do |letter|
      if letters.include?(letter.upcase)
        letters.remove(letter.upcase)
      else
        valid = false
      end
    end
    valid
  end
end
