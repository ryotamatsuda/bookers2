class HomeController < ApplicationController

  before_action :check_login_user

  def check_login_user
    if current_user
      flash[:notice]="すでにログイン中です"
      redirect_to user_path(current_user.id)
    end
  end

  def top
  end

  def about
  end

end
