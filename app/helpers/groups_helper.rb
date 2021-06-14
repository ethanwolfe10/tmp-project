module GroupsHelper

    def current_group
        Group.find(params[:id])
    end

    def group_mod_check
        return true if current_group.mod_id == current_user.id
    end
end
