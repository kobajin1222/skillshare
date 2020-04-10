class User < ApplicationRecord
  validates :name, presence: true, length: { in: 2..10 }
  validates :email, presence: true, length: { maximum: 255 },
                    format: { with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i },
                    uniqueness: { case_sensitive: false }
  validates :self_introduction, length: { maximum: 50 }
  has_secure_password
  validates :password, presence: true, length: { in: 6..20 }
  
  has_many :articles
  has_many :relationships
  has_many :followings, through: :relationships, source: :follow
  has_many :reverses_of_relationship, class_name: 'Relationship', foreign_key: 'follow_id'
  has_many :followers, through: :reverses_of_relationship, source: :user
  has_many :favorites
  has_many :likes, through: :favorites, source: :article
  
  def follow(other_user)
    unless self == other_user
      self.relationships.find_or_create_by(follow_id: other_user.id)
    end
  end

  def unfollow(other_user)
    relationship = self.relationships.find_by(follow_id: other_user.id)
    relationship.destroy if relationship
  end

  def following?(other_user)
    self.followings.include?(other_user)
  end
  
  def feed_articles
    Article.where(user_id: self.following_ids + [self.id])
  end
  
  def favorite(article)
    favorites.find_or_create_by(article_id: article.id)
  end
  
  def unfavorite(article)
    favorite = favorites.find_by(article_id: article.id)
    favorite.destroy if favorite
  end
  
  def favorite?(article)
    self.likes.include?(article)
  end
  
end
