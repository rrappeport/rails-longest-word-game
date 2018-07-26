require 'open-uri'

class GamesController < ApplicationController
  def new
    @letters = [*('A'..'Z')].to_a.sample(10)
  end

  def score
    grid = params[:letters].split
    @exists = params[:word].chars.all? { |letter| params[:word].count(letter) <= grid.count(letter) }
    result
  end

  private

  def english_word?
    response = open("https://wagon-dictionary.herokuapp.com/#{params[:word].downcase}")
    json = JSON.parse(response.read)
    return json['found']
  end

  def result
     if @exists == false
      @result = "Your word #{params[:word]} does not exist in the grid!"
     elsif @exists == true && english_word? == false
      @result = "Your word #{params[:word]} exists in the grid but is not an English word!"
     else
      @result = "Your word #{params[:word]} exists in the grid and is a proper English word!"
     end
  end
end
