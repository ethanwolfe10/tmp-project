class GroupsController < ApplicationController

    before_action :set_group, only: [:show, :edit, :update, :destroy]
    before_action :permitted_user?, only: :show
    before_action :permitted_moderator?, only: [:edit, :update, :destroy]

    def new
        @group = Group.new
    end

    def create
        @group = Group.create(group_params)
        if @group.valid?
            @group.save
            redirect_to group_path(@group)
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

    def edit
    end

    def update
        if @group.update(group_params)
            redirect_to group_path(@group)
        else
            render :edit
        end
    end

    def destroy
        if @group.mod == current_user
            @group.destroy
            redirect_to user_path(current_user)
        end
    end

    private

    def set_group
        @group = Group.find(params[:id])
    end

    def permitted_moderator?
        if @group.mod != current_user
            @group.errors.add(:mod, "Not Mod")
            redirect_to group_path(@group)
        else
            return true
        end
    end

    def permitted_user?
        if Subscription.permitted_user(@group, current_user) == nil
            redirect_to user_path(current_user)
        else
            return true
        end
    end

    def group_params
        params.require(:group).permit(:name, :bio, :mod_id)
    end
end
