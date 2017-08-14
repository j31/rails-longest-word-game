class LongestWordController < ApplicationController

  def game
    grid_size = params[:size]
    @grid = (0...grid_size.to_i).map { (65 + rand(26)).chr }
  end


  def score
    start = params[:start].to_i
    stop = Time.now.to_i
    grid = params[:grid].split(',')
    @attempt = params[:guess]

    # calculate elapsed time

    @result = {}
    @result[:time] = stop - start
    @result[:score] = 0

    # open dictionary
    url = "https://wagon-dictionary.herokuapp.com/#{@attempt.downcase}"
    dict_result = JSON.parse(open(url).read)

    # check if attempt is a real word
    if dict_result["found"] == false
      @result[:message] = "not an english word"
    # check if in grid with awesome array logic that doesn't work in all cases!
    elsif @attempt.upcase.split("") & grid != @attempt.upcase.split("")
     @result[:message] = "not in the grid"
    # calculate score
    else
      @result[:message] = "well done"
      @result[:score] = (((2**@attempt.length.to_f) - @result[:time].to_f) * 10).round()


    end
  end
end
