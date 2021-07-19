class UsersController < ApplicationController

    
    before_action :set_user, only: [:show, :edit, :update]

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
        if @user.update(user_params)
            redirect_to user_path
        else
            #redirect back with error
        end
    end

    private

    def set_user
        @user = User.find(params[:id])
    end

    def user_params
        params.require(:user).permit(:display_name, :bio)
    end

end