class Prototypes::NewestController < ApplicationController
  def index
    @prototypes = Prototype.includes(:user, :captured_images)
                           .page(params[:page])
                           .order('created_at desc')
  end
end
