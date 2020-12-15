class User < ApplicationRecord
    
    has_secure_password
    
    validates :name, {presence: true}
    validates :email, {presence: true, uniqueness: true}
    
    has_many :likes, dependent: :destroy
    has_many :posts, dependent: :destroy
    
    def posts
    return Post.where(user_id: self.id).order(created_at: :desc)
    end
end
