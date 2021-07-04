class FollowsController < ApplicationController

    def index
        @all_users = User.all
        @user = User.find(params[:user_id])
        if params[:query]
            @followers = @user.followers
            render 'followers_index'
        else 
            @followings = @user.followings
            render 'following_index'
        end
    end

    def create
        @follows = Follow.create(follower_id: current_user.id, followed_user_id: params[:user_id])
        if @follows.valid?
            @follows.save
            redirect_back(fallback_location: root_path)
        end
    end

    def destroy
        @follow = Follow.find(params[:id])
        if current_user.id == @follow.follower_id
            @follow.destroy
            redirect_back(fallback_location: root_path)
        end
    end

end
