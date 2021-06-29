module UsersHelper

    def all_user_groups(user, invite=false)
        Group.where(id: Subscription.where(user_id: user.id, confirmed: invite).map(&:group_id))
    end

    def not_following?
        if !Follow.find_by(follower_id: current_user.id, followed_user_id: params[:id])
            return true
        else
            Follow.find_by(follower_id: current_user.id, followed_user_id: params[:id])
        end
    end


end