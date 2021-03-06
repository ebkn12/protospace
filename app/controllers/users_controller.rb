class UsersController < ApplicationController
  before_action :authenticate_user!, only: %i[edit update]
  before_action :set_current_user, only: %i[edit update mypage]

  def edit; end

  def update
    if @user.update(user_params)
      redirect_to root_url, notice: 'ユーザー情報を更新しました。'
      sign_in(current_user, bypass: true)
    else
      flash.now[:warning] = 'ユーザー情報の更新に失敗しました。'
      render :edit
    end
  end

  def show
    @user = User.find(params[:id])
    @prototypes = @user.prototypes
                       .includes(:captured_images, :tag_taggings, :tags)
                       .order(created_at: :desc).page(params[:page])
  end

  def mypage
    @prototypes = @user.prototypes
                       .includes(:captured_images, :tag_taggings, :tags)
                       .order(created_at: :desc).page(params[:page])
    render :show
  end

  private

  def set_current_user
    @user = current_user
  end

  def user_params
    params.require(:user).permit(
      :name,
      :email,
      :password,
      :password_confirmation,
      :avatar,
      :occupation,
      :profile,
      :position
    )
  end
end
