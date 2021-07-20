module LikesHelper

    def already_liked?(post, user)
        return true if Like.find_by(post_id: post.id, user_id: user.id)
    end

    def return_like(post, user)
        Like.find_by(post_id: post.id, user_id: user.id)
    end
    
end
