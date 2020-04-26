class ApplicationController < ActionController::Base
  
  include SessionsHelper
  
  before_action :require_user_logged_in
    
  private
  #ログインしているかを調べるメソッド
  def require_user_logged_in
    unless logged_in?
      redirect_to login_url
    end
  end
  
  def counts(user)
    @count_articles = user.articles.count
    @count_followings = user.followings.count
    @count_followers = user.followers.count
    @count_likes = user.likes.count
  end
  

end
