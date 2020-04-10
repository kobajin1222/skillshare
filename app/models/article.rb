class Article < ApplicationRecord
  belongs_to :user
  has_many :favorites, dependent: :destroy
  has_many :users, through: :favorites
  
  validates :title, presence: true, length: { maximum: 20 }
  validates :content, presence: true, length: { maximum: 2000 }
end
