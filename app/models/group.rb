class Group < ApplicationRecord
    
    belongs_to :mod, class_name: 'User'

    has_many :subscriptions
    has_many :subscribers, -> { Subscription.accepted },  class_name: "User", foreign_key: "user_id", through: :subscriptions
    has_many :posts

    validates :name, uniqueness: true, presence: true, length: { in: 4..15 }, format: { without: /\A[a-zA-Z0-9]+\z/, message: "does not allow special characters" }
    validates :bio, length: { in: 1..50 }
    validates :mod_id, presence: true

    after_create :create_first_subscriber
    after_destroy :clear_house



    private

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

end
