require 'json'
require 'open-uri'

class GamesController < ApplicationController
  def new
    @letters = (0...10).map { ('a'..'z').to_a[rand(26)] }
  end

  def score
    @taille = params[:word].length
    @tableau = params[:wordchain]
    if params[:word].split("").sort != @tableau[0..@taille]
      @answer = "The word can't be built out of the original grid"
    elsif englishword == false
      @answer = "The word is valid according to the grid, but is not a valid English word"
    else
      @answer = "The word is valid according to the grid and is an English word"
    end
  end

  def englishword
    url = open("https://wagon-dictionary.herokuapp.com/#{params[:word]}").read
    fileparsed = JSON.parse(url)
    return fileparsed[:found]
  end
end
