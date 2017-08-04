class PrototypesController < ApplicationController
  def index
    @prototypes = Prototype.includes(:user)
                           .order('created_at desc')
  end

  def show
    @prototype = Prototype.find(params[:id])
    @user = @prototype.user
    @main_image, @sub_images = divide_images(@prototype.captured_images)
  end

  def new
    @prototype = Prototype.new
    @prototype.captured_images.build
  end

  def create
    @prototype = Prototype.new(prototype_params)
    if @prototype.save
      redirect_to root_url, notice: 'Prototype successfully created.'
    else
      render :new
    end
  end

  private

  def prototype_params
    params.require(:prototype).permit(
      :title,
      :catch_copy,
      :concept,
      :captured_image,
      captured_images_attributes: %i[id content status]
    ).merge(user_id: current_user.id)
  end

  def divide_images(images)
    sub = []
    images.each do |image|
      sub << image if image.status.zero?
    end

    [images.first, sub]
  end
end
