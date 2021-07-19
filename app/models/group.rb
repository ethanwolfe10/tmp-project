class Group < ApplicationRecord
    

    has_many :subscriptions
    has_many :subscribers, -> { Subscription.accepted },  class_name: "User", foreign_key: "user_id", through: :subscriptions
    has_many :invitees, -> { Subscription.invited },  class_name: "User", foreign_key: "user_id", through: :subscriptions
    has_many :requests, -> { Subscription.invited }, through: :subscriptions
    belongs_to :mod, class_name: 'User'

    has_many :posts

    validates :name, uniqueness: true, presence: true, length: { in: 4..15 }, format: { with: /\A[a-zA-Z0-9 ]+\z/, message: "does not allow special characters" }
    validates :bio, length: { in: 1..50 }
    validates :mod_id, presence: true

    after_create :create_first_subscriber
    after_destroy :clear_house

    def filter_posts_by(params)
        if params[:filter].include?("Most")
            self.posts.order("#{params[:filter].split(" ")[1].downcase}_count DESC")
        elsif params[:filter] == "Recent Posts"
            self.recent_posts
        elsif params[:filter] == "Old Posts"
            self.old_posts            
        end
    end

    def valid_poster?(user)
        return true if self.subscribers.include?(user)
    end

    def recent_posts
        self.posts.order("created_at ASC")
    end
    
    def old_posts
        self.posts.order("created_at DESC")
    end

    def create_first_subscriber
        Subscription.create(user_id: mod_id, group_id: self.id, moderator: true, confirmed: true)
    end

    def clear_house
        self.posts.each do |post|
            post.comments.destroy_all
            post.likes.destroy_all
        end
        self.subscriptions.destroy_all
    end

    def self.most_subscribers
        Group.order("groups.subscribers DESC").first 
    end
    

end
