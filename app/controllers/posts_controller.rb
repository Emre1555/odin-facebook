class PostsController < ApplicationController

  def index 
    @posts = Post.where(:user_id => current_user.friends).or(Post.where(:user_id => current_user.id)).order("created_at DESC")
    @users = User.all
  end

  def show
    @post = Post.where(:user_id => current_user.friends).or(Post.where(:user_id => current_user.id)).find(params[:id])
    @comment = @post.comments.build
  end

  def new
    @post = Post.new
  end

  def create
    @post = Post.new(post_params)
    @post.user = current_user
    if @post.save
      redirect_to posts_path
    else
      flash[:error] = "Unable to create post."
      render :new
    end
  end

  def edit
    @post = Post.find(params[:id])
  end

  def update
    @post = Post.find(params[:id])
    if @post.update(post_params)
      redirect_to posts_path
    else
      render :edit
    end
  end

  def destroy
    @post = Post.find(params[:id])
    @post.destroy
    redirect_to root_path
  end

  private

  def post_params
    params.require(:post).permit(:content, :current_user)
  end

end