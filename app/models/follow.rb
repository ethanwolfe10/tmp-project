class Follow < ApplicationRecord
    belongs_to :follower, foreign_key: :follower_id, class_name: "User"
    belongs_to :followed_user, foreign_key: :followed_user_id, class_name: "User"

    validates :follower_id, presence: true
    validates :followed_user_id, presence: true

    after_validation :not_already_followed?

    private

    def not_already_followed?
        return false if Follow.find_by(follower_id: self.follower_id, followed_user_id: self.followed_user_id)
    end
end
