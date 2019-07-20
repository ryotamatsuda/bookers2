class BookCommentsController < ApplicationController

  def create
    @book_comment=BookComment.new(book_comment_params)
    @book_comment.user_id=current_user.id
    @book_comment.book_id=params[:book_id]
    if @book_comment.save
      redirect_to book_path(@book_comment.book_id)
    else
      @book_new=Book.new
      @book=Book.find(params[:book_id])
      @book_comments=BookComment.where(book_id: @book.id)
      render "books/show"
    end
  end

  def destroy
    book_comment=BookComment.find_by(id: params[:id])
    book_comment.destroy
    redirect_to book_path(book_comment.book_id)
  end

  private

  def book_comment_params
    params.require(:book_comment).permit(:comment)
  end

end
