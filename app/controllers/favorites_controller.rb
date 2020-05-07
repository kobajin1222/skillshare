class FavoritesController < ApplicationController
  
  def create
    article = Article.find(params[:article_id])
    current_user.favorite(article)
    favorite_message("記事をお気に入りに追加しました")
  end

  def destroy
    article = Article.find(params[:article_id])
    current_user.unfavorite(article)
    favorite_message("記事をお気に入りから削除しました")
  end
  
  private
  
  def favorite_message(message)
    flash[:success] = message
    redirect_back(fallback_location: root_path)
  end
end