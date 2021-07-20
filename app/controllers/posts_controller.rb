class PostsController < ApplicationController

  before_action :set_post, only: [:show, :update, :edit, :destroy]
  before_action :can_post?, only: :create
  before_action :can_view?, only: :show

  def index
  end

  def new
    @post = Post.new
  end

  def create
    @post = Post.new(post_params)
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
    if post_params
      @post.update(title: "EDITED #{params[:post][:title]}", content: "EDITED #{params[:post][:content]}")
      @post.save
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

  def can_view?
    if @post.group.subscribers.include?(current_user) || @post.group.invitees.include?(current_user)
      return true
    else
      redirect_to user_path(current_user), flash: { notice: "Cannot View Post" }
    end
  end

  def can_post?
    if Group.find(params[:group_id]).valid_poster?(current_user)
      return true 
    else
      redirect_to group_path(params[:group_id]), flash: { notice: "Cannot Post" }
    end
  end

  def post_params
    params.require(:post).permit(:title, :content, :user_id, :group_id)
  end
end
