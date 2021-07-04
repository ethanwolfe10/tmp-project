class Like < ApplicationRecord
    belongs_to :post, counter_cache: true
    belongs_to :liker, class_name: "User", foreign_key: "user_id"

    validates :user_id, presence: true
    validates :post_id, presence: true

    after_validation :not_already_liked?

    private

    def not_already_liked?
        if Like.exists?(user_id: self.user_id, post_id: self.post_id)
            errors.add(:base, "You've Already Liked This Post!")
        else
            return true
        end
    end
    
end
