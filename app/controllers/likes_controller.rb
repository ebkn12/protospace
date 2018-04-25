class LikesController < ApplicationController
  before_action :authenticate_user!, only: %i[like unlike]
  before_action :set_prototype, only: %i[create destroy]

  def create
    like = current_user.likes.build(prototype_id: @prototype.id)
    flash[:warning] = '失敗しました。' unless like.save
  end

  def destroy
    like = current_user.likes.find_by(prototype_id: @prototype.id)
    flash[:warning] = '失敗しました。' unless like.destroy
  end

  private

  def set_prototype
    @prototype = Prototype.find(params[:prototype_id])
  end
end
