class ArticlesHashtag < ApplicationRecord
  belongs_to :article
  belongs_to :hashtag
end
