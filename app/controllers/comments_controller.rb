class CommentsController < ApplicationController
  def create
    @prototype = Prototype.find(params[:prototype_id])
    @comment = current_user.comments.build(comment_params)
    flash[:warning] = 'コメントの投稿に失敗しました。' unless @comment.save
  end

  private

  def comment_params
    params.require(:comment).permit(:content).merge(prototype_id: params[:prototype_id])
  end
end
