class FavoritesController < ApplicationController
  
  def create
    article = Article.find(params[:article_id])
    current_user.favorite(article)
    flash[:success] = "記事をお気に入りに追加しました"
    redirect_back(fallback_location: root_path)
  end

  def destroy
     article = Article.find(params[:article_id])
     current_user.unfavorite(article)
     flash[:success] = "記事をお気に入りから削除しました"
     redirect_back(fallback_location: root_path)
  end
end
