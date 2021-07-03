class Group < ApplicationRecord
    
    belongs_to :mod, class_name: 'User'

    has_many :subscriptions
    has_many :subscribers, -> { Subscription.accepted },  class_name: "User", foreign_key: "user_id", through: :subscriptions
    has_many :posts

    validates :name, uniqueness: true, presence: true, length: { in: 4..15 }, format: { without: /[0-9]/, message: "does not allow numbers" }
    validates :bio, length: { in: 1..50 }
    validates :mod_id, presence: true

    after_create :create_first_subscriber



    private

    def create_first_subscriber
        Subscription.create(user_id: mod_id, group_id: self.id, moderator: true, confirmed: true)
    end

end
