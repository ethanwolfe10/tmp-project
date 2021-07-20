module PostsHelper

    def current_post
        @post = Post.find(params[:post_id])
    end


    

end
