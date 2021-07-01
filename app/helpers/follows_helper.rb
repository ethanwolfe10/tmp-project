module FollowsHelper

    def follow_record(user)
        Follow.find_by(follower_id: current_user.id, followed_user_id: user.id)
    end

end
