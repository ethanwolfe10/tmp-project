class CommentsController < ApplicationController

    before_action :set_comment, only: [:show, :destroy]
    before_action :can_comment?, only: :create

    def new
        @comment = Comment.new
        @post = Post.find(params[:post_id])
    end

    def create
        @comment = Comment.new(comment_params)
        if @comment.valid?
            @comment.save
            redirect_to post_path(@comment.post_id)
        else
            render :new
        end
    end

    def show
    end

    def destroy
        if @comment.user == current_user
            @comment.destroy
            redirect_to group_post_path(@comment.post.group_id, @comment.post)
        end
    end

    private

    def can_comment?
        return true if Post.find(params[:comment][:post_id]).group.subscribers.include?(current_user)
    end

    def set_comment
        @comment = Comment.find(params[:id])
    end

    def comment_params
        params.require(:comment).permit(:user_id, :post_id, :content)
    end

end
