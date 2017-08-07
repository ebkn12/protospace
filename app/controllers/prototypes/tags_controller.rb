class Prototypes::TagsController < ApplicationController
  def index
    @tags = Prototype.all_tags
  end

  def show
    @tag_name = params[:tag_name]
    @prototypes = Prototype.related_tag(@tag_name, params[:page])
  end
end
