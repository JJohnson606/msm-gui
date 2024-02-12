class MoviesController < ApplicationController
  def index
    matching_movies = Movie.all
    @list_of_movies = matching_movies.order({ :created_at => :desc })

    render({ :template => "movie_templates/index" })
  end

  def show
    the_id = params.fetch("path_id")

    matching_movies = Movie.where({ :id => the_id })
    @the_movie = matching_movies.at(0)

    render({ :template => "movie_templates/show" })
  end

  def create
     
    @movie = Movie.new

    @movie.title = params.fetch("query_title")
    @movie.year = params.fetch("query_year")
    @movie.duration = params.fetch("query_duration")
    @movie.description = params.fetch("query_description")
    @movie.image = params.fetch("query_image")
    @movie.director_id = params.fetch("query_director_id")
  
    if @movie.save
      flash[:notice] = "Movie created successfully."
      redirect_to("/movies/")
    else
      flash[:alert] = "Movie failed to create successfully."
      redirect_to("/movies")
    end
    pp @movie
  end
  
  def update
    the_id = params.fetch("path_id")
    @movie_new = Movie.where({ :id => the_id }).at(0)

    @movie_new.title = params.fetch("query_title")
    @movie_new.year = params.fetch("query_year")
    @movie_new.duration = params.fetch("query_duration")
    @movie_new.description = params.fetch("query_description")
    @movie_new.image = params.fetch("query_image")
    @movie_new.director_id = params.fetch("query_director_id")

    if @movie_new.valid?
      @movie_new.save
      redirect_to("/movies/#{@movie_new.director_id}", { :notice => "Course updated successfully."} )
    else
      redirect_to("/movies/#{@movie_new.director_id}", { :alert => "Course failed to update successfully." })
    end
  end

  def destroy
    the_id = params.fetch("path_id")
    @movie = Movie.where({ :id => the_id }).at(0)

    @movie.destroy

    redirect_to("/movies", { :notice => "Movie deleted successfully."} )
  end
end
