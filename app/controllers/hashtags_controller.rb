class HashtagsController < ApplicationController
  def index
    @hashtags = Hashtag.order(id: :desc)
  end
end
