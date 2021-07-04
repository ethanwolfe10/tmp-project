module UsersHelper

    def all_user_groups(user, invite=false)
        Group.where(id: Subscription.where(user_id: user.id, confirmed: invite).map(&:group_id))
    end

    def unfollowed_users(user)
        User.where(id: Follow.where.not(follower_id: user.id).map(&:followed_user_id))
    end


end

