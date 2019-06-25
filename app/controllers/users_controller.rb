class UsersController < ApplicationController

  before_action :authenticate_user!
  before_action :check_user_id, only: [:edit,:update]
  before_action :book_for_list

  def book_for_list
    @book_for_list=Book.new
  end

  def check_user_id
    @user=User.find(params[:id])
    if @user.id != current_user.id
      flash[:notice]="権限がありません"
      redirect_to user_path(current_user.id)
    end
  end

  def index
    @users=User.all
    @book=Book.new
  end

  def show
    @user=User.find(params[:id])
    @book=Book.new
  end

  def edit
    @user=User.find(params[:id])
  end

  def update
    @user=User.find(params[:id])
    if @user.update(user_params)
      flash[:notice]="update successfully"
      redirect_to user_path(@user.id)
    else
      render :edit
    end
  end

  private
  def user_params
    params.require(:user).permit(:name,:introduction,:profile_image)
  end
end
