class PostsController < ApplicationController

  before_action :set_post, only: [:show, :update, :edit, :destroy]
  before_action :check_post_params, only: :create

  def index
  end

  def new
    @post = Post.new
  end

  def create
    @post = Post.create(post_params)
    if @post.valid?
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
    if @post.update(post_params)
      @post.update(title: "EDITED: #{params[:post][:title]}", content: "EDITED: #{params[:post][:content]}")
      redirect_to group_post_path(@post)
    else
      render :edit
    end
  end

  def destroy
    if @post.user == current_user
      @post.destroy
      redirect_to group_path(params[:group_id])
    end
  end

  private

  def set_post
    @post = Post.find(params[:id])
  end

  def check_user_params
    return true if Group.find(params[:group_id]).subscribers.include?(current_user)
  end

  def post_params
    params.require(:post).permit(:title, :content, :user_id, :group_id)
  end
end
