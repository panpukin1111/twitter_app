class Admin::UserGroupsController < Admin::ApplicationController
  before_action :set_user, only: :destroy
    
  def create
  end
  
  def destroy
    GroupUser.find(params[:user_id]).destroy
    flash[:success] = "退会しました"
    redirect_to admin_user_path(@user)
  end
  
  private
    def set_user
      @user = User.find(params[:id])
    end
  
end