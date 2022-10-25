class CommentsController < ApplicationController
  def new
    @post = Post.find(params[:post_id])
    @comment = @post.comments.build
  end


  def create
    @post = Post.find(params[:post_id])
    @comment = @post.comments.new(comment_params)
    @comment.user = current_user

    respond_to do |format|
      if @comment.save
        format.html { redirect_to @post, notice: 'Comment was successfully created.' }
      end
    end

    #respond_to do |format|
    #  if @comment.save
    #    format.html { redirect_to @comment.post, notice: "Comment was successfully created." }
    #  else
    #    format.html { render partial: "posts/comment_form" }
    #  end
    #end
  end
            

  def delete
    @comment = Comment.find(params[:id])
    @comment.destroy
    redirect_to @comment.post
  end

  private

  
  def comment_params
    params.require(:comment).permit(:text, :post_id, :user_id)
  end

end
