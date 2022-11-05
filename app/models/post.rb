class Post < ApplicationRecord
    belongs_to :user
    has_many :likes, as: :likable
    has_many :comments, dependent: :destroy
    

    validates :content, presence: true, length: { maximum: 200 }
end
