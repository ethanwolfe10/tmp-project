module FollowsHelper

    def return_follow(follower, user)
        Follow.find_by(follower_id: follower.id, followed_user_id: user.id)
    end

    def already_followed?(follower, followed_user)
        return true if Follow.find_by(follower_id: follower, followed_user_id: followed_user.id)
    end

end
