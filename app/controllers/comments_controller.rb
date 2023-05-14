class CommentsController < ApplicationController
  def create
    comment = current_user.comments.build(comment_params)
    if comment.save
      redirect_to post_path(comment.post)
      flash[:alert] = t('defaults.message.created')
    else
      redirect_to post_path(comment.post)
      flash[:alert] = t('defaults.message.not_created')
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:body).merge(post_id: params[:post_id])
  end
end
