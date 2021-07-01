class CommentsController < ApplicationController

    before_action :set_comment, only: [:show, :destroy]

    def new
        @comment = Comment.new
    end

    def create
        @comment = Comment.new(comment_params)
        if @comment.save
            redirect_to post_comment_path(@comment)
        end
    end

    def show
    end

    def destroy
    end

    private

    def set_comment
        @comment = Comment.find(params[:id])
    end

    def comment_params
        params.require(:comment).permit(:user_id, :post_id, :title, :content)
    end

end
