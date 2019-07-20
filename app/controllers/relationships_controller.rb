class RelationshipsController < ApplicationController

  before_action :book_new

  def book_new
    @book_new=Book.new
  end

  def create
    relationship=Relationship.new(following_id: current_user.id, follower_id: params[:user_id])
    if relationship.following_id != relationship.follower_id 
      relationship.save
    end
    redirect_back(fallback_location: root_path)
  end

  def destroy
    relationship=Relationship.find_by(following_id: current_user.id, follower_id: params[:user_id])
    relationship.destroy
    redirect_back(fallback_location: root_path)
  end

  def following_index
    @user=User.find(params[:user_id])
  end

  def follower_index
    @user=User.find(params[:user_id])
  end

end
