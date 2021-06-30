module UsersHelper

    def all_user_groups(user, invite=false)
        Group.where(id: Subscription.where(user_id: user.id, confirmed: invite).map(&:group_id))
    end

    


end

