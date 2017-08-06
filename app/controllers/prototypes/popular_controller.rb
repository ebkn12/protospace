class Prototypes::PopularController < ApplicationController
  def index
    @prototypes = Prototype.includes(:user, :captured_images)
                           .joins(:likes)
                           .order('likes_count desc')
                           .order('created_at desc')
                           .page(params[:page])
  end
end
