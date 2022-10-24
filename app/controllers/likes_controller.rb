class LikesController < ApplicationController

  def create 
    @like = current_user.likes.new(like_params)
    if @like.save
      redirect_back(fallback_location: root_path)
    else
      flash[:error] = "Unable to like post."
      redirect_back(fallback_location: root_path)
    end 
  end

  def destroy
    @like = Like.find(params[:id])
    @like.destroy
    redirect_back(fallback_location: root_path)
  end

  private

  def like_params
    params.require(:like).permit(:likable_id, :likable_type)
  end


end
