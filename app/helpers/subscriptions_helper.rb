module SubscriptionsHelper

    def status_check(user, group)
        return false if Subscription.find_by(user_id: user.id, group_id: group.id)
    end

    def subscription_exists(user)
        return true if Subscription.find_by(user_id: user.id, group_id: params[:group_id])
    end

    def no_eligible_members?
        current_user.followers.each do |fllwr|
            return true if Subscription.find_by(user_id: fllwr.id, group_id: params[:group_id]) == nil
        end
    end

    def current_sub(group, user)
        Subscription.find_by(user_id: user.id, group_id: group.id)
    end

    def ask_to_join?(user, group)
        return true if Subscription.find_by(user_id: user.id, group_id: group.id) == nil
    end

end
