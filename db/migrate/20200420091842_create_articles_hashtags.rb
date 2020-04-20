class CreateArticlesHashtags < ActiveRecord::Migration[5.2]
  def change
    create_table :articles_hashtags, id: false do |t|
      t.references :article, foreign_key: true
      t.references :hashtag, foreign_key: true
      
      t.index [:article_id,:hashtag_id], unique: true
    end
  end
end
