class UsersController < ApplicationController

    before_action :set_user, only: [:show, :edit, :update]
    before_action :set_username, only: :show

    def index
        if params[:query] == "invite"
            @users = Group.find(params[:group_id]).invitees
        else
            @users = Group.find(params[:group_id]).subscribers
        end       
    end

    def show
        if current_user == @user
            render 'showself'            
        end
    end

    def create
        binding.pry
    end

    def edit
        
    end

    def update
        if @user.update(user_params)
            @user.save
            redirect_to user_path(@user), flash: { notice: "Update Successful" }
        else
            redirect_to edit_user_path(current_user), flash: { error: "Update Unsuccessful" }
        end
    end

    private

    def set_username
        if @user.display_name == nil
            @user.display_name = @user.username
            @user.username = "@#{@user.username}"
            @user.save
        end
    end

    def set_user
        @user = User.find(params[:id])
    end

    def user_params
        params.require(:user).permit(:display_name, :bio)
    end

end