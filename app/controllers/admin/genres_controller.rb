class Admin::GenresController < ApplicationController

  def index
    @genre = Genre.new
    @genres = Genre.all
    respond_to do |wants|
      wants.html # index.html.erb
      wants.xml  { render :xml => @genres }
    end
  end

  def create
    @genre = Genre.new(genre_params)
      if @genre.save
        flash[:notice] = 'ModelClassName was successfully created.'
        redirect_to admin_genres_path
      else
        render :index
      end
  end

  def edit
    @genre = Genre.find(params[:id])
  end

  def update
    @genre = Genre.find(params[:id])
      if @genre.update(genre_params)
        flash[:notice] = 'Genre was successfully updated.'
        redirect_to "/admin/genres"
      else
        render :edit
      end
  end

  private

  def genre_params
    params.require(:genre).permit(:name)
  end
end
