class RelationshipsController < ApplicationController

  def create
    user = User.find(params[:follow_id])
    current_user.follow(user)
    follow_message('ユーザをフォローしました。')
  end

  def destroy
    user = User.find(params[:follow_id])
    current_user.unfollow(user)
    follow_message('ユーザのフォローを解除しました。')
  end
  
  private
  
  def follow_message(message)
    flash[:success] = message
    redirect_back(fallback_location: root_path)
  end
end