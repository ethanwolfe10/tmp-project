module FollowsHelper

    def not_following?(user)
        if !Follow.find_by(follower_id: current_user.id, followed_user_id: user.id)
            return true
        else
            Follow.find_by(follower_id: current_user.id, followed_user_id: user.id)
        end
    end

end
