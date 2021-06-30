module GroupsHelper

    def confirmed_member(group)
        return true if group.subscribers.include?(current_user)
    end

    def current_group
        Group.find(params[:group_id])
    end
end
