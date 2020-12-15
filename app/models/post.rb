class Post < ApplicationRecord
    
    validates :content, {presence:true, length: {maximum: 300}}
    validates :title, {presence: true}
    validates :user_id, {presence: true}
    
    belongs_to :user
    has_many :likes, dependent: :destroy
    
    def user
      return User.find_by(id: self.user_id)
    end
    
end

