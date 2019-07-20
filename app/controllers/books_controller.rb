class BooksController < ApplicationController

  before_action :authenticate_user!
  before_action :book, only: [:check_user_id,:show,:edit,:update,:destroy]
  before_action :check_user_id, only: [:edit,:update,:destroy]
  before_action :book_new

  def book
    @book=Book.find(params[:id])
  end

  def check_user_id
    if @book.user_id != current_user.id
      flash[:notice]="権限がありません"
      redirect_to books_path
    end
  end

  def book_new
    @book_new=Book.new
  end

  def index
    @books=Book.includes(:user)
    @following_user=current_user.followings
  end

  def show
    @book_comments=BookComment.where(book_id: @book.id)
    @book_comment=BookComment.new
  end

  def create
    @book=Book.new(book_params)
    @book.user_id=current_user.id
    if @book.save
      flash[:notice]="create successfully"
      redirect_to "/books/#{@book.id}"
    else
      @books=Book.all
      @book_new=@book
      render :index
    end
  end

  def edit
  end

  def update
    if @book.update(book_params)
      flash[:notice]="update successfully"
      redirect_to book_path(@book.id)
    else
      render :edit
    end
  end

  def destroy
    @book.destroy
    redirect_to books_path
  end

  private
  def book_params
    params.require(:book).permit(:title,:body)
  end
end
