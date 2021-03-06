class Admin::UsersController < Admin::ApplicationController
    # before_action :logged_in_user, only: [:index, :edit, :update, :destroy, :following, :followers]
    # before_action :correct_user,   only: [:edit, :update]
    # before_action :admin_user,     only: :destroy
  
    def index
      @users = User.where(activated: true).paginate(page: params[:page])
    end
  
    def show
      @user = User.find(params[:id])
      @groups = @user.group_users
    end

    def show_micropost
      @user = User.find(params[:id])
      @microposts = @user.microposts.paginate(page: params[:page])
    end
  
    def new
      @user = User.new
    end
  
    def create
      @user = User.new(user_params)
      if @user.save
        # UserMailer.account_activation(@user).deliver_now の書き換え
        @user.send_activation_email
        flash[:info] = "メールをご確認の上アカウントを有効化してください"
        redirect_to root_url
      else
        render 'new'
      end
    end
  
    def edit
      @user = User.find(params[:id])
    end
  
    def update
      @user = User.find(params[:id])
      if @user.update_attributes(user_params)
        flash[:success] = "プロフィールを変更しました"
        redirect_to admin_users_path
      else
        render 'edit'
      end
    end
  
    def destroy
      User.find(params[:id]).destroy
      flash[:success] = "ユーザーを削除しました"
      redirect_to admin_users_path
    end

    # def exit_room
    #   GroupUser.find(params[:id]).destroy
    #   flash[:success] = "退会しました"
    #   render 'index'
    # end
  
    private
      def user_params
        params.require(:user).permit(:name, :email, :admin, :activated, :status)
      end

end
