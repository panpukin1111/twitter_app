class Admin::GroupsController < Admin::ApplicationController
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
      @group = Group.find(params[:id])
    end
  
    def update
      @group = Group.find(params[:id])
      if @group.update_attributes(group_params)
        flash[:success] = "界隈の内容を変更しました"
        redirect_to admin_groups_path
      else
        render 'edit'
      end
    end
  
    def destroy
      Group.find(params[:id]).destroy
      flash[:success] = "界隈を削除しました"
      redirect_to admin_groups_path
    end
  
    private
      def group_params
        params.require(:group).permit(:name, :description, :status)
      end

end