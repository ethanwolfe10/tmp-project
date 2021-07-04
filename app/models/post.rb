class Post < ApplicationRecord
    belongs_to :user
    belongs_to :group
    has_many :comments
    has_many :likes
    has_many :likers, foreign_key: 'user_id', class_name: 'User', through: :likes

    validates :title, presence: true, length: { maximum: 30 }, format: { with: /\A[a-zA-Z0-9 ]+\z/, message: "does not allow special characters" }
    validates :content, presence: true, length: { maximum: 500 }
    validates :group_id, presence: true

    
    # scope :desc, order("posts.created_at DESC")

    

    private

    
end
