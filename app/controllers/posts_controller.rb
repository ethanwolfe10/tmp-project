class PostsController < ApplicationController
  def index
  end

  def new
  end

  def create
    @post = Post.create(post_params)
    if @post.save
      redirect_to group_path(id: params[:group_id])
    else
      #redirect w/ error message
    end
  end

  def show
    @post = Post.find(params[:id])
  end

  def edit
  end

  def update
  end

  private

  def post_params
    params.require(:post).permit(:title, :content, :user_id, :group_id)
  end
end
