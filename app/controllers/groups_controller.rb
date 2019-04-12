class GroupsController < ApplicationController
    # before_action :logged_in_user, only: [:index, :edit, :update, :destroy, :following, :followers]
    # before_action :correct_user,   only: [:edit, :update]
    # before_action :admin_user,     only: :destroy
  
    def index
      @groups = Group.all.paginate(page: params[:page])
    end
  
    def show
      @group = Group.find(params[:id])
      @users = @group.group_users
    #   @microposts = @user.microposts.paginate(page: params[:page])
    #   redirect_to root_url and return unless @user.activated?
    end
  
    def new
      @group = Group.new
    end
  
    def create
      @group = Group.new(group_params)
      if @group.save
        redirect_to root_url
      else
        render 'new'
      end
    end
  
    def edit
      @user = Group.find(params[:id])
    end
  
    def update
    #   @group = Group.find(params[:id])
    #   if @group.update_attributes(user_params)
    #     flash[:success] = "プロフィールを変更しました"
    #     redirect_to @user
    #   else
    #     render 'edit'
    end
  
    def destroy
      Group.find(params[:id]).destroy
      flash[:success] = "グループを削除しました"
      redirect_to users_url
    end
  
    private
      def user_params
        params.require(:group).permit(:name, :description)
      end
  
      # 正しいユーザーかどうか確認(before_action にすることでedit やupdate の権限は本人だけになる)
    #   def correct_user
    #     @user = User.find(params[:id])
    #     redirect_to(root_url) unless current_user?(@user)
    #   end
  
    #   def admin_user
    #     redirect_to(root_url) unless current_user.admin?
    #   end
end