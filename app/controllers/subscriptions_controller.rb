class SubscriptionsController < ApplicationController

    after_action :last_subscription, only: :destroy
    before_action :set_sub, only: [:edit, :update]
    
    

    def new
        @sub = Subscription.new
    end

    def create
        
        @new_sub = Subscription.create(subscription_params)
        binding.pry
        if @new_sub.valid?
            binding.pry
            @new_sub.save
            redirect_to group_path(@new_sub.group_id)
        end
    end

    def edit
        
    end

    def update
        if params[:query] 
            @sub.update(confirmed: true)
        else
            @sub.update(status: params[:subscription][:status], status_color: params[:subscription][:status_color])
            @sub.save
        end
        redirect_to group_path(@sub.group_id)
    end

    def destroy
        binding.pry      
        @sub = Subscription.find(params[:id])
        if @sub.user_id == current_user.id
            @sub.destroy
            redirect_to user_path(current_user)
        end
    end

    private

    def last_subscription
        if Group.find(params[:group_id]).subscribers.empty?
            Group.find(params[:group_id]).destroy
        else
            return true
        end
    end

    def set_sub
        @sub = Subscription.find_by(user_id: current_user.id, group_id: params[:group_id])
    end

    def subscription_params
        binding.pry
        params.require(:subscription).permit(:user_id, :group_id, :moderator, :confirmed)
    end

    
end
