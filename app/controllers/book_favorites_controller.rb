class BookFavoritesController < ApplicationController

  before_action :book_new, only: [:show]

  def show
    
    @favorites=BookFavorite.includes(:user)
    @book_id=params[:book_id]
  end

  def create
    book_favorite=BookFavorite.new(book_id: params[:book_id], user_id: current_user.id)
    book_favorite.save
    redirect_back(fallback_location: root_path)
  end

  def destroy
    book_favorite=BookFavorite.find_by(book_id: params[:book_id], user_id: current_user.id)
    book_favorite.destroy
    redirect_back(fallback_location: root_path)
  end

  def book_new
    @book_new=Book.new
  end

end
