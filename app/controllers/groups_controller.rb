class GroupsController < ApplicationController

    before_action :set_group, only: [:show, :update, :destroy]

    def new
        @group = Group.new
    end

    def create
        # binding.pry
        @group = Group.create(group_params)
        if @group.valid?
            @group.save
            redirect_to group_path(@group)
        else
            render :new
        end
    end

    def show
    end

    def edit
    end

    def update
        if @group.update(group_params)
            redirect_to group_path(@group)
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

    def group_params
        params.require(:group).permit(:name, :bio, :mod_id)
    end
end
