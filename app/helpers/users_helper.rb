module UsersHelper

    def user_groups
        binding.pry
        Group.find(current_user.subscriptions.map(&:group_id))
    end

end