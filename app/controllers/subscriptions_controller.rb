class SubscriptionsController < ApplicationController

    after_action :last_subscription, only: :destroy
    

    def new
        @subscription = Subscription.new
    end

    def create
        @new_sub = Subscription.new(subscription_params)
        if @new_sub.save
            redirect_to new_group_subscription_path
        end
    end

    def destroy        
        @sub = Subscription.find(params[:id])
        if @sub.user_id == current_user.id
            @sub.destroy
            redirect_to user_path(current_user)
        end
    end

    private

    def last_subscription
        if Group.find(params[:id]).subscribers.empty?
            Group.find(params[:id]).destroy
        else
            return true
        end
    end

    def subscription_params
        params.require(:subscription).permit(:user_id, :group_id, :moderator, :confirmed)
    end

    
end
