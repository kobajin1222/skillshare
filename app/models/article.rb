class Article < ApplicationRecord
  belongs_to :user
  has_many :favorites, dependent: :destroy
  has_many :users, through: :favorites
  has_many :tagmanagements, dependent: :destroy
  has_many :hashtags, through: :tagmanagements, source: :hashtag
  
  validates :title, presence: true, length: { maximum: 20 }
  validates :content, presence: true, length: { maximum: 2000 }

  #記事(article)保存後に処理
  after_create do
    article = Article.find_by(id: self.id)
    #保存した記事のcontentの中から#の後に続くハッシュタグをスキャンして配列に入れる
    hashtags  = self.content.scan(/[#＃][\w\p{Han}ぁ-ヶｦ-ﾟー]+/)
    hashtags.uniq.map do |hashtag|
      #ハッシュタグを'#'を外して保存
      tag = Hashtag.find_or_create_by(hashname: hashtag.downcase.delete('#'))
      #中間テーブルに記事のidとハッシュタグのidを保存
      Tagmanagement.find_or_create_by(article_id: article.id,hashtag_id: tag.id)
    end
  end
  
  #記事更新前のデータを代入
  before_update do
    @before_article = Article.find_by(id: self.id)
  end

  after_update do
    article = Article.find_by(id: self.id)
    #記事idを持った中間テーブルカラムを全件削除する
    Tagmanagement.where(article_id: article.id).destroy_all
    hashtags = self.content.scan(/[#＃][\w\p{Han}ぁ-ヶｦ-ﾟー]+/)
    hashtags.uniq.map do |hashtag|
      tag = Hashtag.find_or_create_by(hashname: hashtag.downcase.delete('#'))
      Tagmanagement.find_or_create_by(article_id: article.id,hashtag_id: tag.id)
    end
    #更新前の記事のcontentの中から#の後に続くハッシュタグをスキャンして配列に入れる
    hashtags  = @before_article.content.scan(/[#＃][\w\p{Han}ぁ-ヶｦ-ﾟー]+/)
    hashtags.uniq.map do |hashtag|
      tag = Hashtag.find_by(hashname: hashtag.downcase.delete('#'))
      #ハッシュタグが持つ記事が無ければそのハッシュタグを削除
      if tag.articles.blank?
        tag.destroy
      end
    end
  end
  
  after_destroy do
    hashtags  = self.content.scan(/[#＃][\w\p{Han}ぁ-ヶｦ-ﾟー]+/)
    hashtags.uniq.map do |hashtag|
      tag = Hashtag.find_by(hashname: hashtag.downcase.delete('#'))
      if tag.articles.blank?
        tag.destroy
      end
    end
  end
  
end
