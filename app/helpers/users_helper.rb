module UsersHelper

    def all_user_groups(invite=false)
        binding.pry
        Group.where(id: Subscription.where(user_id: current_user.id, confirmed: invite).map(&:group_id))
    end


end