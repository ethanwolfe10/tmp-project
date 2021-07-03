class PostsController < ApplicationController

  before_action :set_post, only: [:show, :update, :edit]

  def index
  end

  def new
    @post = Post.new
  end

  def create
    @post = Post.create(post_params)
    if @post.valid
      @post.save
      redirect_to group_path(id: params[:group_id])
    else
      render :new
    end
  end

  def show
    
  end

  def edit
  end

  def update
  end

  private

  def set_post
    @post = Post.find(params[:id])
  end

  def post_params
    params.require(:post).permit(:title, :content, :user_id, :group_id)
  end
end
