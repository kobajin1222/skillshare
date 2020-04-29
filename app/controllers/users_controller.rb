class UsersController < ApplicationController
  
  skip_before_action :require_user_logged_in, only: [:new, :create]
  before_action :correct_user, only: [:edit, :update]
  
  def index
    @users = User.order(id: :desc).page(params[:page]).per(5)
  end
  
  def show
    @user = User.find(params[:id])
    @articles = @user.articles.order(id: :desc).page(params[:page]).per(4)
    counts(@user)
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)

    if @user.save
      flash[:success] = 'ユーザを登録しました。'
      session[:user_id] = @user.id
      redirect_to @user
    else
      flash.now[:danger] = 'ユーザの登録に失敗しました。'
      render :new
    end
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])

    if @user.update(user_params)
      flash[:success] = 'ユーザー情報を変更しました。'
      redirect_to @user
    else
      flash.now[:danger] = 'ユーザー情報の変更に失敗しました。'
      render :edit
    end
  end
  
  def followings
    @user = User.find(params[:id])
    @followings = @user.followings.page(params[:page]).per(5)
    counts(@user)
  end
  
  def followers
    @user = User.find(params[:id])
    @followers = @user.followers.page(params[:page]).per(5)
    counts(@user)
  end
  
  def likes
    @user = User.find(params[:id])
    @likes = @user.likes.page(params[:page]).per(4)
    counts(@user)
  end
  
  def search
    @search_word = params[:search]
    @users = User.where("(name like ?) ","%#{@search_word}%").page(params[:page]).per(5)
    @users_count = User.where("(name like ?) ","%#{@search_word}%").count
    
    if @search_word.blank?
      @search_word = "指定なし"
    end
    
  end
  
  private

  def user_params
    params.require(:user).permit(:name, :image, :remove_image, :email, :self_introduction, :password, :password_confirmation)
  end
  def correct_user
    @user =  User.find(params[:id])
    unless current_user == @user
      redirect_to root_url
    end
  end
end
