class SubscriptionsController < ApplicationController

    after_action :last_subscription, only: :destroy
    before_action :set_sub, only: [:edit, :update]

    def new
        @sub = Subscription.new
        @users = User.all
    end

    def create
        @new_sub = Subscription.create(subscription_params)
        if @new_sub.valid?
            @new_sub.save
            redirect_to group_path(@new_sub.group_id), flash: { notice: "Subscription Created Successfully"}
        end
    end

    def edit     
    end

    def update
        if params[:query] 
            @sub.update(confirmed: true)
            notice = "Group Joined Successfully"
        else
            @sub.update(status: params[:subscription][:status], status_color: params[:subscription][:status_color])
            if @sub.valid?
                @sub.save
            else
                render :edit
            end
            notice = "Status Changed Successfully"
        end
        redirect_to group_path(@sub.group_id), flash: { notice: notice }
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
        params.require(:subscription).permit(:user_id, :group_id, :moderator, :confirmed)
    end

    
end
