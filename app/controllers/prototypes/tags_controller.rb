class Prototypes::TagsController < ApplicationController
  def index
    @tags = Prototype.all_tags
  end

  def show
    @prototypes = Prototype.tagged_with(params[:tag_name])
  end
end
