class FavoritesController < ApplicationController
  
def create
  @favorite = current_user.favorites.create(book_id: params[:book_id])
  # redirect_to book_path(@book)
  redirect_back(fallback_location: root_path)
end

def destroy
  @book = Book.find(params[:book_id])
  @favorite = current_user.favorites.find_by(book_id: @book.id)
  @favorite.destroy
  # redirect_to book_path(book)
  redirect_back(fallback_location: root_path)
end
    
end
