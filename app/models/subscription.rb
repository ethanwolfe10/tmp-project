class Subscription < ApplicationRecord
    belongs_to :group
    belongs_to :subscriber, class_name: "User", foreign_key: "user_id"
    belongs_to :invitee, class_name: "User", foreign_key: "user_id"

    scope :accepted, -> { where(confirmed: :true) }
    scope :invited, -> { where(confirmed: :false) }

    validates :user_id, presence: true
    validates :group_id, presence: true
    validates :status_color, presence: false, length: {is: 7, message: "Not Hexadecimal" }
    before_update :check_color_format
    

    def check_color_format
        binding.pry
        errors.add(:status_color, "Not Hexadecimal" ) unless status_color.start_with?("#")
    end

    def self.permitted_user(group, user)
        return true if Subscription.find_by(group_id: group.id, user_id: user.id)
    end

end
