class Admin::UserMicropostsController < Admin::ApplicationController
    # before_action :logged_in_user, only: [:index, :edit, :update, :destroy, :following, :followers]
    # before_action :correct_user,   only: [:edit, :update]
    # before_action :admin_user,     only: :destroy
    before_action :set_user, only: [:index, :edit, :update, :destroy]
  
    def index
      @microposts = @user.microposts.paginate(page: params[:page])
    end
  
    # def show
    #   @micropost = Micropost.find(params[:id])
    # #   @microposts = @user.microposts.paginate(page: params[:page])
    # #   redirect_to root_url and return unless @user.activated?
    # end
  
    def new
      @micropost = Micropost.new
    end
  
    def create
      @micropost = Micropost.new(micropost_params)
      if @micropost.save
        redirect_to root_url
      else
        render 'new'
      end
    end
  
    def edit
      @micropost = Micropost.find(params[:id])
    end
  
    def update
      @micropost = @user.microposts.find(params[:id])
      if @micropost.update_attributes(micropost_params)
        flash[:success] = "投稿の内容を変更しました"
        redirect_to admin_user_microposts_path(@micropost.user_id)
      else
        render 'edit'
      end
    end
  
    def destroy
      @user.microposts.find(params[:id]).destroy
      flash[:success] = "投稿を削除しました"
      redirect_to admin_user_microposts_path
    end
  
    private
      def micropost_params
        params.require(:micropost).permit(:content, :status)
      end

      def set_user
        @user = User.find(params[:user_id])
      end

end