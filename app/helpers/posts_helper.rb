module PostsHelper

    def current_post
        @post = Post.find(params[:post_id])
    end

    def already_liked?(post, user)
       return true if post.likers.include?(user)
    end
    

end
