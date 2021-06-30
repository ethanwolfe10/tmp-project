class SubscriptionsController < ApplicationController

    def new
        @subscription = Subscription.new
    end

    def create
        @new_sub = Subscription.new(subscription_params)
        if @new_sub.save
            redirect_to new_group_subscription_path
        end

    end

    private

    def subscription_params
        params.require(:subscription).permit(:user_id, :group_id, :moderator, :confirmed)
    end

    
end
