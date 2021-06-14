class GroupsController < ApplicationController

    def new
    end

    def create
        @group = Group.new(group_params)
        if @group.save
            redirect_to group_path(@group)
        else
            #redirect back w/ error message
        end
    end

    def show
        @group = Group.find(params[:id])
    end

    def edit
    end

    def update
    end

    private

    def group_params
        params.require(:group).permit(:name, :bio, :mod_id)
    end
end
