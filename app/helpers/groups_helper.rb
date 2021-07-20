module GroupsHelper

    def confirmed_member(group)
        return true if group.subscribers.include?(current_user)
    end

    def current_group
        Group.find(params[:group_id])
    end

    def in_a_group?
        return true if params[:group_id]
    end
end
