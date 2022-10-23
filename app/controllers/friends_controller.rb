class FriendsController < ApplicationController
  before_action :set_friend, only: [:destroy]
  
  def index
    @friends = current_user.friends
    @users = User.all
  end

  def destroy
    current_user.remove_friend(@friend)
    redirect_to friend_path
    head :no_content
  end


  private

  def set_friend
    @friend = User.find(params[:id])
  end


end
