class FollowsController < ApplicationController

    def index
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
        @follows = Follow.create(follow_params)
        if @follows.valid?
            @follows.save
            flash[:notice] = "Followed User"
            redirect_back(fallback_location: root_path)
        end
    end

    def destroy
        @follow = Follow.find(params[:id])
        if current_user.id == @follow.follower_id
            @follow.destroy
            flash[:notice] = "Unfollowed User"
            redirect_back(fallback_location: root_path)
        end
    end

    private

    def follow_params
        params.require(:follow).permit(:follower_id, :followed_user_id)
    end

end
