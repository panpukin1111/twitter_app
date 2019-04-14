class Admin::GroupUsersController < Admin::ApplicationController
  before_action :set_group, only: :destroy
  
  def create
  end

  def destroy
    GroupUser.find(params[:group_id]).destroy
    flash[:success] = "退会させました"
    redirect_to admin_group_path(@group)
  end

  private
    def set_group
      @group = Group.find(params[:id])
    end

end