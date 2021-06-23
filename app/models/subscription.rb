class Subscription < ApplicationRecord
    belongs_to :group
    belongs_to :user

    validates :user_id, presence: true
    validates :group_id, presence: true
    
    after_validation :doesnt_already_exist

    private

    def doesnt_already_exist
        if Subscription.exists?(user_id: self.user_id, group_id: self.group_id)
            errors.add(:base, "User Already Has Pending Invitation")
        end
    end

end
