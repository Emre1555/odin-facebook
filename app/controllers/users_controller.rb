class UsersController < ApplicationController
    def index 
        @users = User.all
        @incoming = FriendRequest.where(friend: current_user)
        @outgoing = current_user.friend_requests
    end

    def show
        @user = User.find(params[:id])
        @posts = @user.posts.order("created_at DESC")
        
    end

    def new
        @user = User.new
    end

    def create
        @user = User.new(user_params)
        if @user.save
             # Tell the UserMailer to send a welcome email after save
            redirect_to users_path
        else
            render :new
        end
    end

    def edit
        @user = User.find(params[:id])
    end

    def update
        @user = User.find(params[:id])
        if @user.update(user_params)
            redirect_to users_path
        else
            render :edit
        end
    end

    def destroy
        
        redirect_to root_path
        @user = User.find(params[:id])
        @user.destroy
        
    end

    private

    
     def user_params
        params.require(:user).permit(:name, :email, :password)
     end

end
