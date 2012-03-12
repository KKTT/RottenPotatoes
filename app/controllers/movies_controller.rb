class MoviesController < ApplicationController

  def show
    id = params[:id] # retrieve movie ID from URI route
    @movie = Movie.find(id) # look up movie by unique ID
    # will render app/views/movies/show.<extension> by default
  end

  def index
		@all_ratings=Movie.ratings
	
		
		if params[:ratings]
			@sel_rating=params[:ratings].keys
		else
			@sel_rating=@all_ratings	
		end
		
		sort=params[:sort]
		if sort=="title"
  		 @movies=Movie.find(:all,:conditions=>{:rating =>@sel_rating},:order=>'title')
			 @type_title="hilite"	
	  elsif sort=="date"
			 @movies=Movie.find(:all,:conditions=>{:rating =>@sel_rating},:order=>'release_date')
			 @type_date="hilite"
		else
			 @movies = Movie.find(:all,:conditions=>{:rating =>@sel_rating})
		end
		session[:ratings]=params[:ratings]
		session[:sort]=params[:sort]
  end

  def new
    # default: render 'new' template
  end

  def create
    @movie = Movie.create!(params[:movie])
    flash[:notice] = "#{@movie.title} was successfully created."
    redirect_to movies_path({:sort=>session[:sort],:ratings=>session[:ratings]})
  end

  def edit
    @movie = Movie.find params[:id]
  end

  def update
    @movie = Movie.find params[:id]
    @movie.update_attributes!(params[:movie])
    flash[:notice] = "#{@movie.title} was successfully updated."
    redirect_to movie_path(@movie)
  end

  def destroy
    @movie = Movie.find(params[:id])
    @movie.destroy
    flash[:notice] = "Movie '#{@movie.title}' deleted."
    redirect_to movies_path({:sort=>session[:sort],:ratings=>session[:ratings]})
  end

end
