class Prototypes::PopularController < ApplicationController
  def index
    @prototypes = Prototype.order_by_popular(params[:page])
  end
end
