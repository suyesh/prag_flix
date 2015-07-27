class MoviesController < ApplicationController
  def index
    @movies = ['Superman', 'Batman', 'Spiderman','Ironman']
  end
end
