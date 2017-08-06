class UsersController < ApplicationController
  def edit
    @user = current_user
  end

  def update
    @user = current_user
    if @user.update(user_params)
      redirect_to root_url, notice: 'ユーザー情報の更新に成功しました'
      sign_in(current_user, bypass: true)
    else
      render :edit
    end
  end

  def show
    @user = User.find(params[:id])
    @prototypes = @user.prototypes.page(params[:page])
  end

  private

  def user_params
    params.require(:user).permit(
      :name,
      :email,
      :password,
      :avatar,
      :occupation,
      :profile,
      :position
    )
  end
end
