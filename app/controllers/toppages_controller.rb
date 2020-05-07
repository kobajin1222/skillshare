class ToppagesController < ApplicationController
  
  skip_before_action :require_user_logged_in
  
  def index
    if logged_in?
      @article = current_user.articles.build
      @articles = current_user.follow_articles.order(id: :desc).page(params[:page]).per(4)
    end
  end
end