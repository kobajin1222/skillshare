class CreateTagmanagements < ActiveRecord::Migration[5.2]
  def change
    create_table :tagmanagements do |t|
      t.references :article, foreign_key: true
      t.references :hashtag, foreign_key: true
      
      t.index [:article_id, :hashtag_id], unique: true
    end
  end
end

