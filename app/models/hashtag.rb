class Hashtag < ApplicationRecord
  has_and_belongs_to_many :articles
  validates :hashname, presence: true, length: { maximum:99 }
end
