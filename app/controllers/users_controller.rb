class UsersController < ApplicationController
  def edit
    @user = current_user
  end

  def update
    @user = current_user
    if @user.update(user_params)
      redirect_to root_url, notice: 'User updated successfully.'
      sign_in(current_user, bypass: true)
    else
      render :edit
    end
  end

  def show
    @user = User.find(params[:id])
    @prototypes = @user.related_prototypes(params[:page])
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
