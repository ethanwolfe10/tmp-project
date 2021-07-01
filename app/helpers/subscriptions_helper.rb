module SubscriptionsHelper

    def sub_to_group(sub)
        Group.find_by(id: sub.group_id)
    end

    def subscription_exist(user)
        return true if Subscription.find_by(user_id: user.id, group_id: params[:group_id])
    end

    def no_eligible_members?
        current_user.followers.each do |fllwr|
            return true if Subscription.find_by(user_id: fllwr.id, group_id: params[:group_id]) == nil
        end
    end

end
