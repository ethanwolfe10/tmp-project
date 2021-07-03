module SubscriptionsHelper

    # def unconfirmed_subs(subs)
    #     binding.pry
    #     subs.where(confirmed: false)
    # end

    def subscription_exists(user)
        return true if Subscription.find_by(user_id: user.id, group_id: params[:group_id])
    end

    def no_eligible_members?
        current_user.followers.each do |fllwr|
            return true if Subscription.find_by(user_id: fllwr.id, group_id: params[:group_id]) == nil
        end
    end

    def current_sub(group)
        Subscription.find_by(user_id: current_user.id, group_id: group.id)
    end

end
