class LikesController < ApplicationController

    before_action :can_like?, only: :create

    def index
        @post = Post.find(params[:post_id])
    end

    def create
        @like = Like.new(like_params)
        if @like.valid?
            @like.save
            redirect_to group_post_path(@like.post.group, @like.post)
        end
    end

    def destroy
        @like = Like.find_by(id: params[:id])
        if @like.user_id == current_user.id 
            @like.destroy
            redirect_to group_post_path(@like.post.group, @like.post)
        end
    end

    private

    def like_params
        params.require(:like).permit(:user_id, :post_id)
    end

    def can_like?
        return true if Post.find(params[:post_id]).group.subscribers.include?(current_user)
    end

end
