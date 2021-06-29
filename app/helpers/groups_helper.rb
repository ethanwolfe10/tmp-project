module GroupsHelper

    def current_group
        Group.where(id: params[:id]).or(Group.where(id: params[:group_id])).first
    end

    def who_is_mod(group)
        User.find(group.mod_id)
    end

    def group_mod_check
        return true if current_group.mod_id == current_user.id
    end
end
