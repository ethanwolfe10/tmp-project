class GroupsController < ApplicationController

    before_action :set_group, only: [:show, :update, :update]

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
    end

    def destroy
        binding.pry
    end

    private

    def set_group
        @group = Group.find(params[:id])
    end

    def group_params
        params.require(:group).permit(:name, :bio, :mod_id)
    end
end
