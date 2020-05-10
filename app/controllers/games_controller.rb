require 'json'
require 'open-uri'

class GamesController < ApplicationController

  # Steps:
  # 1. Display new letters
  def new
    @letters_list = ("A".."Z").to_a.sample(10)

  end

  def score
    # 2. Organise both the User input and the Dislay
    # 3. Check if it uses letters from the display array
    @user_word = params[:user_word]
    @clean_word = @user_word.upcase.split(//)
    @letters = params[:letters].gsub(/\s+/, '').split(//)

    # 4. Check if the word is made from the list of 10
    @common = @clean_word & @letters # Find common letters
    @made_from_list = @common.length == @clean_word.length #Check if user word is same as common letters

    # 5. Check if exists from parsing API T/F
    @check = word_exist(@user_word)
  end

  #5.1 Check if exists from parsing API T/F
  # => Parse JSON
  def word_exist(input)
    @url = "https://wagon-dictionary.herokuapp.com/#{input}" # String
    @new_info = open(@url).read # String
    @parsed = JSON.parse(@new_info) # Hash
    @is_real = @parsed.values[0] # Returns T/F if word is legit
  end

end
