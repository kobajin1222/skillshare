class ApplicationController < ActionController::Base
  
  include SessionsHelper
  
  before_action :require_user_logged_in

  helper_method :helper_category_search, :helper_category_save

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

  def category_list
    [
      "インターネット・コンピュータ","エンターテインメント",
      "生活・文化","社会・経済","健康と医療","ペット","グルメ",
      "住まい","花・ガーデニング","育児","旅行・観光","写真",
      "手芸・ハンドクラフト","スポーツ","アウトドア",
      "美容・ビューティー","ファッション","恋愛・結婚",
      "趣味・ホビー","ゲーム","乗り物","芸術・人文",
      "学問・科学","日記・雑談","ニュース","地域情報","その他"
    ]
  end

  def helper_category_search
    category_list
  end
  
  def helper_category_save
    category_select = []
    category_list.each do |category|
      category_save = [category,category]
      category_select << category_save
    end
  end
end
