class LikesController < ApplicationController
  def like
    @prototype = Prototype.find(params[:prototype_id])
    like = current_user.likes.build(prototype_id: @prototype.id)
    flash[:warning] = 'Like failed.' unless like.save
  end

  def unlike
    @prototype = Prototype.find(params[:prototype_id])
    like = current_user.likes.find_by(prototype_id: @prototype.id)
    flash[:warning] = 'Unlike failed.' unless like.destroy
  end
end
