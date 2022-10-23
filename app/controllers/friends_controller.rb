class FriendsController < ApplicationController
  before_action :set_friend, only: [:destroy]
  
  def index
    @friends = current_user.friends
    @users = User.all
  end

  def destroy
    current_user.friends.destroy(@friend)
    redirect_to root_path
    head :no_content
  end


  private

  def set_friend
    @friend = Friendship.find(params[:id])
  end


end
