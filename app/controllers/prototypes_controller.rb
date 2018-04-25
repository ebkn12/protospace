class PrototypesController < ApplicationController
  before_action :authenticate_user!, only: %i[new create edit update destroy]
  before_action :set_prototype, only: %i[show edit update destroy]

  def index
    @prototypes = Prototype.order_by_newest(params[:page])
  end

  def show
    @user = @prototype.user
    @main_image, @sub_images = images_src(@prototype)
    @comment = Comment.new
    @comments = @prototype.related_comments(params[:page])
  end

  def new
    @prototype = Prototype.new
    @prototype.captured_images.build
  end

  def create
    @prototype = Prototype.new(prototype_params)
    if @prototype.save
      redirect_to root_url, notice: 'プロトタイプを投稿しました。'
    else
      flash.now[:warning] = 'プロトタイプの投稿に失敗しました。'
      render :new
    end
  end

  def edit
    @main_image, @sub_images = images_src(@prototype)
  end

  def update
    if @prototype.update(prototype_params)
      redirect_to root_url, notice: 'プロトタイプを更新しました。'
    else
      flash.now[:warning] = 'プロトタイプの更新に失敗しました。'
      render :edit
    end
  end

  def destroy
    @prototype.destroy
    redirect_to root_url, notice: 'プロトタイプを削除しました。'
  end

  private

  def prototype_params
    params.require(:prototype).permit(
      :title,
      :catch_copy,
      :concept,
      :captured_image,
      tag_list: [],
      captured_images_attributes: %i[id content status]
    ).merge(user_id: current_user.id)
  end

  def set_prototype
    @prototype = Prototype.find(params[:id])
  end

  def images_src(prototype)
    main = prototype.main_image ? prototype.main_image.content.to_s : nil
    sub  = prototype.sub_images ? prototype.sub_images.map(&:content).map(&:to_s) : nil

    [main, sub]
  end
end
