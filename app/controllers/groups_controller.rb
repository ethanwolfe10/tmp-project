class GroupsController < ApplicationController

    before_action :set_group, only: [:show, :edit, :update, :destroy]
    before_action :permitted?, only: :show
    before_action :moderator?, only: [:edit, :update, :destroy]

    def index
        @user = User.find(params[:user_id])
    end

    def new
        @group = Group.new
    end

    def create
        @group = Group.create(group_params)
        if @group.valid?
            @group.save
            redirect_to group_path(@group), flash: { notice: "Group Successfully Created" }
        else
            render :new
        end
    end

    def show
        if !params[:filter].blank?
            @posts = @group.filter_posts_by(params)
        else
            @posts = @group.posts
        end
    end

    def most_subscribers
        @group = Group.most_subscribers
    end

    def edit
    end

    def update
        if @group.update(group_params)
            redirect_to group_path(@group), flash: { notice: "Group Successfully Updated" }
        else
            redirect_to group_path(@group), flash: { error: "Group Unsuccessfully Updated" }
        end
    end

    def destroy
        if @group.destroy
            redirect_to user_path(current_user), flash: { notice: "Group Successfully Deleted" }
        else
            redirect_to user_group_path(current_user), flash: { error: "Unsuccessful Deletion" }
        end
    end

    private

    def set_group
        @group = Group.find(params[:id])
    end

    def moderator?
        if @group.moderator == current_user
            return true
        else
            @group.errors.add(:mod, "You're Not A Moderator")
            redirect_to group_path(@group)
        end
    end

    def permitted?
        if @group.subscribers.include?(current_user) || @group.invitees.include?(current_user)
            return true
        else
            redirect_to user_path(current_user), flash: { error: "You're Not Permitted"}
        end
    end

    def group_params
        params.require(:group).permit(:name, :bio, :mod_id)
    end
end
