class ArticlesController < ApplicationController
  before_action :correct_user, only: [:edit, :update, :destroy]
  
  def index
      @article = current_user.articles.build
      @articles = Article.order(id: :desc).page(params[:page]).per(4)
  end

  def show
    @article = Article.find_by(id: params[:id])
    @user = @article.user
  end

  def new
    @article = current_user.articles.build
  end

  def create
    @article = current_user.articles.build(article_params)
    if @article.save
      flash[:success] = '記事を投稿しました。'
      redirect_to @article
    else
      flash.now[:danger] = '記事の投稿に失敗しました。'
      render :new
    end
  end

  def edit
    @article = Article.find_by(id: params[:id])
  end

  def update
    @article = Article.find_by(id: params[:id])
    if @article.update(article_params)
      flash[:success] = '記事を更新しました。'
      redirect_to @article
    else
      @articles = current_user.articles.order(id: :desc).page(params[:page])
      flash.now[:danger] = '記事の更新に失敗しました。'
      render :edit
    end
  end

  def destroy
    @user = @article.user
    @article.destroy
    flash[:success] = '記事を削除しました。'
    redirect_to @user
  end
  
  def hashtag
    @hashtag = Hashtag.find_by(hashname: params[:hashname])
    @articles = @hashtag.articles.page(params[:page]).per(4)
  end
  
  def search
    @search_word = params[:search]
    @search_category = params[:category]

    #@articles = Article.where("(title like ?) OR (content like ?)", "%#{@search_word}%", "%#{@search_word}%").where(category: @search_category).page(params[:page]).per(4)
    
    if @search_category.blank?
      @articles = Article.where("(title like ?) OR (content like ?)", "%#{@search_word}%", "%#{@search_word}%").page(params[:page]).per(4)
      @articles_count = Article.where("(title like ?) OR (content like ?)", "%#{@search_word}%", "%#{@search_word}%").count
    else
      @articles = Article.where("(title like ?) OR (content like ?)", "%#{@search_word}%", "%#{@search_word}%").where(category: @search_category).page(params[:page]).per(4)
      @articles_count = Article.where("(title like ?) OR (content like ?)", "%#{@search_word}%", "%#{@search_word}%").where(category: @search_category).count
    end
    
  end
  
  def category
    @category = params[:category]
    @articles = Article.where(category: @category).page(params[:page]).per(4)
  end
  
  private

  def article_params
    params.require(:article).permit(:title,:content,:category)
  end
  
  def correct_user
    @article = current_user.articles.find_by(id: params[:id])
    unless @article
      redirect_to root_url
    end
  end
end
