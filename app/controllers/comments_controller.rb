class CommentsController < ApplicationController

    before_action :set_comment, only: [:show, :destroy]

    def new
        @comment = Comment.new
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
        if @comment.post.user == current_user
            @comment.destroy
            redirect_to group_post_path(@comment.post.group_id, @comment.post)
        end
    end

    private

    def set_comment
        @comment = Comment.find(params[:id])
    end

    def comment_params
        params.require(:comment).permit(:user_id, :post_id, :content)
    end

end
