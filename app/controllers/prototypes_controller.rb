class PrototypesController < ApplicationController
  before_action :authenticate_user!, only: %i[new create edit update destroy]

  def index
    @prototypes = Prototype.includes(:user, :captured_images)
                           .order('created_at desc')
  end

  def show
    @prototype = set_prototype
    @user = @prototype.user
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

  def edit
    @prototype = set_prototype
  end

  def update
    @prototype = set_prototype
    if @prototype.update(prototype_params)
      redirect_to root_url, notice: 'Prototype successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    prototype = set_prototype
    prototype.destroy
    redirect_to root_url, notice: 'Prototype successfully deleted.'
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

  def set_prototype
    Prototype.find(params[:id])
  end
end
