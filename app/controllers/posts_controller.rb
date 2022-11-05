class PostsController < ApplicationController


  def index 
    @posts = Post.where(:user_id => current_user.friends).or(Post.where(:user_id => current_user.id)).order("created_at DESC")
    @users = User.all
    @post = Post.new
  end

  def show
    @post = Post.where(:user_id => current_user.friends).or(Post.where(:user_id => current_user.id)).find(params[:id])
    @comment = @post.comments.build
  end

  def new
    @post = Post.new
  end

  def create
    @posts = Post.where(:user_id => current_user.friends).or(Post.where(:user_id => current_user.id)).order("created_at DESC")
    @users = User.all
    @post = Post.new(post_params)
    @post.user = current_user
    if @post.save
      redirect_to posts_path
    else
      render :index ,status: :unprocessable_entity
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
    if current_user == @post.user
      @post.destroy
      redirect_to root_path
    else
      flash[:error] = "You can't delete this post."
      redirect_to root_path
    end
  end

  private

  def post_params
    params.require(:post).permit(:content, :current_user)
  end

end