class UsersController < ApplicationController

    before_action :set_user, only: [:show, :edit, :update]
    before_action :set_username, only: :show

    def index
        
    end

    def show
        if current_user == @user
            render 'showself'            
        end
    end

    def edit
        
    end

    def update
        binding.pry
        if @user.update(user_params)
            @user.save
            binding.pry
            redirect_to user_path
        else
            redirect_to edit_user_path(current_user), flash: { error: "Update Unsuccessful" }
        end
    end

    private

    def set_username
        if @user.display_name == nil
            @user.display_name = @user.username
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