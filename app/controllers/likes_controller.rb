class LikesController < ApplicationController
  before_action :authenticate_user!, only: %i[like unlike]

  def like
    @prototype = set_prototype
    like = current_user.likes.build(prototype_id: @prototype.id)
    flash[:warning] = '失敗しました。' unless like.save
  end

  def unlike
    @prototype = set_prototype
    like = current_user.likes.find_by(prototype_id: @prototype.id)
    flash[:warning] = '失敗しました。' unless like.destroy
  end

  private

  def set_prototype
    Prototype.find(params[:prototype_id])
  end
end
