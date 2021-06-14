module SubscriptionsHelper

    def sub_to_group(sub)
        Group.find_by(id: sub.group_id)
    end
end
