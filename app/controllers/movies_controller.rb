class MoviesController < ApplicationController

  def movie_params
    params.require(:movie).permit(:title, :rating, :description, :release_date)
  end

  def show
    id = params[:id] # retrieve movie ID from URI route
    @movie = Movie.find(id) # look up movie by unique ID
    # will render app/views/movies/show.<extension> by default
  end

  def index
    @all_ratings = Movie.all_ratings
    @ratings     = params[:ratings]
    
    if !session.has_key?(:ratings)
      session[:ratings]=Movie.all_ratings
    end
    
    if (params[:sort_by] or session[:sort_by]) == 'title'
      @title_header = 'hilite'
    elsif (params[:sort_by] or session[:sort_by]) == 'release_date'
      @release_date_header ='hilite'
    end
    
    if params.has_key?(:ratings) and !@ratings.nil? and @ratings.keys.length > 0
    session[:ratings]=params[:ratings].keys
    
    end
    
    if params.has_key?(:sort_by)
      session[:sort_by]=params[:sort_by]
    end
    @movies = Movie.where(rating: session[:ratings]).order(session[:sort_by])
    
  end


  def new
    # default: render 'new' template
  end

  def create
    @movie = Movie.create!(movie_params)
    flash[:notice] = "#{@movie.title} was successfully created."
    redirect_to movies_path
  end

  def edit
    @movie = Movie.find params[:id]
  end

  def update
    @movie = Movie.find params[:id]
    @movie.update_attributes!(movie_params)
    flash[:notice] = "#{@movie.title} was successfully updated."
    redirect_to movie_path(@movie)
  end

  def destroy
    @movie = Movie.find(params[:id])
    @movie.destroy
    flash[:notice] = "Movie '#{@movie.title}' deleted."
    redirect_to movies_path
  end

end
