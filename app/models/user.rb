class User < ApplicationRecord
  validates :name, presence: true, length: { in: 2..10 }
  validates :email, presence: true, length: { maximum: 255 },
                    format: { with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i },
                    uniqueness: { case_sensitive: false }
  validates :self_introduction, length: { maximum: 50 }
  has_secure_password
  validates :password, presence: true, length: { in: 6..20 }
  
end
