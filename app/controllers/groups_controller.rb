class GroupsController < ApplicationController
    # before_action :logged_in_user, only: [:index, :edit, :update, :destroy, :following, :followers]
    # before_action :correct_user,   only: [:edit, :update]
    # before_action :admin_user,     only: :destroy
  
    def index
      @user = current_user
      @groups = current_user.groups
      @follow_users = current_user.following
      group_id = current_user.groups.ids
      room_users = []
      (1..(group_id.count)).each do |i|
        room_users.push(Group.find(group_id[i-1]).users)  
      end
      room_users = room_users.uniq.first
      @followable_users = room_users - current_user.following - [current_user]
      # binding.pry
    end
  
    def show
      @group = Group.find(params[:id])
      @users = @group.users.paginate(page: params[:page]).search(params[:search])
      @search = params[:search]
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
      # binding.pry
      Group.find(params[:id]).destroy
      flash[:success] = "グループを削除しました"
      redirect_to users_url
    end
  
    def invitable_users
      # binding.pry
      @group = Group.find(params[:id])
      room_users = []
      group_id = current_user.groups.ids
      (1..(group_id.count)).each do |i|
        room_users.push(Group.find(group_id[i-1]).users)  
      end
      room_users = room_users.uniq.first
      @invitable_users = (room_users - @group.users)
      # binding.pry
    end

    def invite
      GroupUser.create(user_id: params[:invite_id], group_id: params[:id])
      redirect_to :action => "invitable_users"
    end

    private
      def user_params
        params.require(:group).permit(:name, :description)
      end
  
      # 正しいユーザーかどうか確認(before_action にすることでedit やupdate の権限は本人だけになる)
      def correct_user
        @user = User.find(params[:id])
        redirect_to(root_url) unless current_user?(@user)
      end
  
      def admin_user
        redirect_to(root_url) unless current_user.admin?
      end
end