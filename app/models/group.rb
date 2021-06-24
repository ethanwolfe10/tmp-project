class Group < ApplicationRecord
    has_many :subscriptions
    has_many :subscribers, class_name: "User", foreign_key: "user_id", through: :subscriptions
    has_many :posts

    validates :name, presence: true, length: { in: 4..15 }
    validates :bio, presence: true, length: { in: 1..50 }
    validates :mod_id, presence: true

    after_create :create_first_subscriber

    private

    def create_first_subscriber
        Subscription.create(user_id: mod_id, group_id: self.id, moderator: true, confirmed: true)
    end

end
