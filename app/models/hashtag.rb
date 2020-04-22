class Hashtag < ApplicationRecord
  has_many :tagmanagements, dependent: :destroy
  has_many :articles, through: :tagmanagements, source: :article
  validates :hashname, presence: true, length: { maximum:99 }
end
