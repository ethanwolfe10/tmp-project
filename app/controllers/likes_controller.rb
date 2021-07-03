class LikesController < ApplicationController

    def index
        @post = Post.find(params[:post_id])
    end

    def create
        @like = Like.new(user_id: current_user.id, post_id: params[:post_id])
        if @like.save
            redirect_to group_post_path(@like.post.group, @like.post)
        end
    end

    def destroy
        @like = Like.find(params[:id])
        if @like.user_id == current_user.id 
            @like.destroy
            redirect_to group_post_path(@like.post.group, @like.post)
        end
    end

end
