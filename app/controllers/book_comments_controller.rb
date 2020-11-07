class BookCommentsController < ApplicationController
    
  def create
      book = Book.find(params[:book_id])
      comment = current_user.book_comments.new(book_comment_params)
      comment.book_id = book.id
      comment.save
      redirect_back(fallback_location: root_path)
      # @book_comment = BookComment.new
      # @book_comments = @book.book_comments
      # redirect_to request.referer
     
  end
    

  def destroy
    @comment = BookComment.find_by(id: params[:id], book_id: params[:book_id])
    @comment.destroy
    # @comment = BookComment.new
    # redirect_to request.referer
    # redirect_back(fallback_location: root_path)
  end
  
  private
  def book_comment_params
    params.require(:book_comment).permit(:comment)
  end
  
end
