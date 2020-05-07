class ArticlesController < ApplicationController
  before_action :correct_user, only: [:edit, :update, :destroy]
  before_action :set_article, only: [:index, :new]
  before_action :article_find, only: [:show, :edit, :update]
  before_action :set_user, only: [:show, :destroy]
  
  def index
      @articles = Article.order(id: :desc).page(params[:page]).per(4)
  end

  def show
  end

  def new
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
  end

  def update
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
    @article.destroy
    flash[:success] = '記事を削除しました。'
    redirect_to @user
  end
  
  def hashtag
    @hashtag = Hashtag.find_by(hashname: params[:hashname])
    @articles = @hashtag.articles.page(params[:page]).per(4)
  end
  
  # def search
  #   @search_word = params[:search]
  #   @search_category = params[:category]
    
  #   if @search_category.blank?
  #     @articles = Article.where("(title like ?) OR (content like ?)", "%#{@search_word}%", "%#{@search_word}%").page(params[:page]).per(4)
  #     @articles_count = Article.where("(title like ?) OR (content like ?)", "%#{@search_word}%", "%#{@search_word}%").count
  #   else
  #     @articles = Article.where("(title like ?) OR (content like ?)", "%#{@search_word}%", "%#{@search_word}%").where(category: @search_category).page(params[:page]).per(4)
  #     @articles_count = Article.where("(title like ?) OR (content like ?)", "%#{@search_word}%", "%#{@search_word}%").where(category: @search_category).count
  #   end
    
  #   if @search_word.blank?
  #     @search_word = "指定なし" 
  #   end
  #   if @search_category.blank? 
  #     @search_category = "指定なし" 
  #   end 
  # end
  def search
    @search_word = params[:search]
    
    if params[:category_id].blank?
      @articles = Article.where("(title like ?) OR (content like ?)", "%#{@search_word}%", "%#{@search_word}%").page(params[:page]).per(4)
      @articles_count = Article.where("(title like ?) OR (content like ?)", "%#{@search_word}%", "%#{@search_word}%").count
    else
      @category = Category.find(params[:category_id])
      @articles = Article.where("(title like ?) OR (content like ?)", "%#{@search_word}%", "%#{@search_word}%").where(category_id: @category.id).page(params[:page]).per(4)
      @articles_count = Article.where("(title like ?) OR (content like ?)", "%#{@search_word}%", "%#{@search_word}%").where(category_id: @category.id).count
    end
    
    if @search_word.blank?
      @search_word = "指定なし" 
    end
  end
  
  def category
    @category = Category.find(params[:category_id])
    @articles = @category.articles.page(params[:page]).per(4)
  end
  
  private
  
  def set_article
    @article = current_user.articles.build
  end
  
  def set_user
    @user = @article.user
  end
  
  def article_find
    @article = Article.find_by(id: params[:id])
  end

  def article_params
    params.require(:article).permit(:title,:content,:category_id)
  end
  
  def correct_user
    @article = current_user.articles.find_by(id: params[:id])
    unless @article
      redirect_to root_url
    end
  end
end