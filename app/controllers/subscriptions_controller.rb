class SubscriptionsController < ApplicationController

    after_action :last_subscription, only: :destroy
    

    def new
        @subscription = Subscription.new
    end

    def create
        @new_sub = Subscription.new(subscription_params)
        if @new_sub.save
            redirect_to new_group_subscription_path(@new_sub.group_id)
        end
    end

    def update
        binding.pry
        @sub = Subscription.find_by(user_id: current_user.id, group_id: params[:group_id])
        @sub.update(confirmed: true)
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
        binding.pry
        if Group.find(params[:group_id]).subscribers.empty?
            Group.find(params[:group_id]).destroy
        else
            return true
        end
    end

    def subscription_params
        params.require(:subscription).permit(:user_id, :group_id, :moderator, :confirmed)
    end

    
end
