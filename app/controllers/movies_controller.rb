class MoviesController < ApplicationController
  def index
    @movies =  Movie.all
  end
# ,"director LIKE '%?%'"  params[:director])
  def show
    @movie = Movie.find(params[:id])
  end

  def new
    @movie = Movie.new
  end

  def edit
    @movie = Movie.find(params[:id])
  end

  def create
    @movie = Movie.new(movie_params)

    if @movie.save
      redirect_to movies_path, notice: "#{@movie.title} was submitted successfully!"
    else
      render :new
    end
  end

  def update
    @movie = Movie.find(params[:id])
    if @movie.update_attributes(movie_params)
      redirect_to movie_path(@movie)
    else
      render :edit
    end
  end

  def destroy
    @movie = Movie.find(params[:id])
    @movie.destroy
    redirect_to movies_path
  end

  def search
    search = ""
    search += "title LIKE '%#{params[:title]}%'" if !params[:title].empty?
    search += "#{' OR' if search.length >0} director LIKE '%#{params[:director]}%'" if !params[:director].empty?
    @movies =  Movie.where(search)

    # @movie =  Movie.where("title like '%?%'", params[:title]) ("title like '%?%'", params[:title])
    case params[:length].to_i
    when 1
      then @movies = @movies.where('runtime_in_minutes <= 90')
    when 2
      then @movies = @movies.where('runtime_in_minutes >= 90 AND runtime_in_minutes <= 180')
    when 3
      then @movies = @movies.where('runtime_in_minutes >= 180')
    end
  end

  protected

  def movie_params
    params.require(:movie).permit(
      :title, :release_date, :director, :runtime_in_minutes, :image, :description
    )
  end
end
